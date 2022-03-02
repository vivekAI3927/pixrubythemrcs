# == Schema Information
#
# Table name: admins
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Admin < ApplicationRecord
	extend Devise::Models

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable


  scope :editor, -> { where(editor: true)}
  has_many :comments, as: :commentable
  attr_accessor :allow_model_name

  validates :email, presence: true
  validates_length_of :email, :maximum => 255
  has_one :admin_access
  before_save :password_required?
  before_update :password_required?

  def password_required?
    if self.password.present?
      true
    else
      false
    end
  end

  
  def super_admin?
    !editor
  end

end
