# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  encrypted_password     :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  subscribed_on          :date
#  referred_by            :string(255)
#  coupon_name            :string(255)
#  country                :string(255)
#  sent_exam_reminder     :boolean          default(FALSE)
#  membership_id          :integer
#  last_question_id       :integer
#  target_exam_date       :date
#  authentication_token   :string(255)
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  remember_created_at    :datetime
#  target_speciality_id   :integer
#  royal_college_id       :string
#  coaching               :boolean
#
class User < ApplicationRecord

  

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :timeoutable

  validates :name, presence: true
  validates :name, length: {within: 6..30 }
  validates :email, uniqueness: true, presence: true, length: { within: 6..40 }
  validates :membership_id, presence: true, on: :create
  validates :target_exam_date, presence: true
  # FOR VALIDATION
  validates :country, presence: true, on: :create
  validates_length_of :referred_by, :maximum => 255
  validates_length_of :coupon_name, :maximum => 255
  # validates :password, presence: true, length: { minimum: 6 }, :on => :create
  # validates :password_confirmation, presence: true, :create => :update, :unless => lambda{ |user| user.password.blank? }
  before_save :password_required?
  before_update :password_required?
  # belongs_to :target_speciality, optional: true
  belongs_to :royal_college

  def password_required?
    if self.password.present?
      true
    else
      false
    end
  end
  
  # validates :referred_by, presence: true
  validates :password, presence: true, :on => :create
  validates :password_confirmation, presence: true, :on => :create

  has_many :exams
  has_many :attempts, :dependent => :delete_all
  has_many :stations, through: :attempts
  belongs_to :membership
  has_many :station_statuses, :dependent => :delete_all
  has_many :payments, :dependent => :delete_all

  after_create :add_attempts
  after_create :send_registration_notification
  after_create :send_interested_coching_email

  has_many :ratings
  has_many :comments, as: :commentable
  before_save :ensure_authentication_token
  # Password reset

  def authenticatable_salt
    "#{super}#{authentication_token}"
  end

  def invalidate_all_sessions!
    self.update_attribute(:authentication_token, SecureRandom.hex)
  end
  # def self.to_csv
  #   # attributes = %w{id email name country subscribed_on}
  #   attributes = %w{id name email encrypted_password created_at updated_at password_reset_token password_reset_sent_at subscribed_on referred_by coupon_name country sent_exam_reminder target_exam_date authentication_token reset_password_token reset_password_sent_at current_sign_in_at last_sign_in_at current_sign_in_ip last_sign_in_ip remember_created_at}
  #   CSV.generate(headers: true) do |csv|
  #     csv << attributes
  #     all.each do |user|
  #       csv << attributes.map{ |attr| user.send(attr) }
  #     end
  #   end
  # end


  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    # UserMailer.password_reset(self).deliver
    UserMailer.delay.password_reset(self)
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  # Tracking

  def add_attempts
    User.delay_add_attamps(self.id)
  end

  def send_interested_coching_email
    UserMailer.user_interested_coching(self).deliver_now if self.coaching == true
  end

  def self.delay_add_attamps(user_id)
    stations_hash = []
    Station.available.each do |station|
      # Attempt.create(station_id: station.id, user_id: user_id)
      stations_hash << {station_id: station.id, user_id: user_id, created_at: Time.now, updated_at: Time.now}
    end
    Attempt.insert_all(stations_hash) if stations_hash.present?
  end

  def update_to_question_id(id)
    update_attribute(:last_question_id, id)
  end

  # Reminders

  def not_received_exam_reminder?
    if valid_subscription?
      return false
    else
      if sent_exam_reminder?
        return false
      else
        return true
      end
    end
  end

  def send_exam_reminder
    update_attributes(sent_exam_reminder: true)
    # UserMailer.delay.exam_reminder(self)
    UserMailer.exam_reminder(self).deliver_later

  end

  def send_not_join_message
    update_attributes(sent_exam_reminder: true)
    # UserMailer.delay.not_join_message(self)
    UserMailer.not_join_message(self).deliver_later
  end

  def send_paid_message
    update_attributes(sent_exam_reminder: true)
    # UserMailer.delay.paid_message(self)
    UserMailer.paid_message(self).deliver_later
  end

  def self.not_joined
    User.where('subscribed_on is NULL').where(:created_at => (Time.now.midnight - 1.week - 1.day)..(Time.now.midnight - 1.week))
  end

  def self.send_not_joined_messages
    self.not_joined.each do |user|
      UserMailer.delay.not_join_message(user)
    end
  end

  def send_registration_notification
    UserMailer.registration_message(self).deliver
  end

  # Membership Core Functionality

  def start_subscription
    update_attributes(subscribed_on: Time.now.to_date, subscribed_expired_at: (Time.now + self.membership.length.months))
  end

  def valid_subscription?
    if self.membership
      if self.membership.length == 1 && self.membership.status == "create" 
        self.update(subscribed_expired_at: DateTime.now + 30)
      end
      # new user with membership
      #if subscribed_on && subscribed_on >= self.membership.length.months.ago.to_date
      if subscribed_on && subscribed_expired_at >= Time.now
        return true
      else
        return false
      end
    else
      # old user with no membership
      if subscribed_on && subscribed_on >= 4.months.ago.to_date
        return true
      else
        return false
      end
    end
  end

  def membership_expired?
    return false if subscribed_on.nil?
     unless subscribed_expired_at >= Time.now
        return true
      else
        return false
      end
  end

  def apply_coupon(coupon_name)
    update_attribute(:coupon_name, coupon_name)
  end

  # generate paypal redirect url
  def paypal_url(return_url, user_id, notify_url, cost)
    values = {
      business: BUSSINESS_EMAIL,
      cmd: '_xclick',
      return: return_url,
      custom: user_id,
      invoice: Time.now,
      currency_code: CURRENCY,
      amount: cost.to_f.round(2),
      no_shipping: 1,
      item_name: "PassTheMRCS Subscription",
      notify_url: notify_url
    }
    PAYPAL_URL + values.to_query
  end

 def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  # Assuming country_select is used with User attribute `country_code`
  # This will attempt to translate the country name and use the default
  # (usually English) name if no translation is available
  def country_name
    if self.country.length == 2
      country = ISO3166::Country[self.country]
      country.translations[I18n.locale.to_s] || country.name
    else
      self.country
    end
  end

  def create_payment(provider="Stripe", params)
    res = params.as_json(:except => [:controller, :action])
    status = params[:status].present? ? params[:status] : "Completed"   
    self.payments.create(status: params[:status], provider: provider, response: res)
  end
  
  private


  def generate_authentication_token
      loop do
        token = SecureRandom.urlsafe_base64
        break token unless User.find_by(authentication_token: token)
      end
  end
end