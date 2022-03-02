class PartaUser < ApplicationRecord
	after_create :send_registration_notification
  # Include default devise modules. Others available are:
  # :confirmable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :lockable, :timeoutable
  
	validates :name, presence: true
  validates :name, length: {within: 6..30 }
  validates :email, uniqueness: true, presence: true, length: { within: 6..40 }
	validates :target_exam_date, presence: true
  validates_length_of :country, :maximum => 255
  belongs_to :target_speciality
  # has_many :parta_category_statuses, :dependent => :delete_all
  has_many :parta_category_statuses, :class_name => "Parta::Category", foreign_key: 'parta_category_id'
	
	def country_name
    if self.country.length == 2
      country = ISO3166::Country[self.country]
      country.translations[I18n.locale.to_s] || country.name
    else
      self.country
    end
  end

  def send_registration_notification
    UserMailer.parta_registration_message(self).deliver
  end
	
	# In the registration form the password is not asked.
  def password_required?
		return false
  end
end
