# == Schema Information
#
# Table name: home_logo_banners
#
#  id                  :bigint           not null, primary key
#  description         :text
#  logo                :string
#  banner              :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  logo_file_name      :string
#  logo_content_type   :string
#  logo_file_size      :integer
#  logo_updated_at     :datetime
#  banner_file_name    :string
#  banner_content_type :string
#  banner_file_size    :integer
#  banner_updated_at   :datetime
#  first_title         :string
#  second_title        :string
#
class HomeLogoBanner < ApplicationRecord

  mount_uploader :logo_file_name,   LogoImageUploader
  mount_uploader :banner_file_name, BannerImageUploader

  validates :first_title, presence: true
  validates_length_of :first_title, :maximum => 255
  validates :second_title, presence: true
  validates_length_of :second_title, :maximum => 255
  validates :description, presence: true
  validates :logo_file_name, presence: true
  validates :banner_file_name, presence: true

  def logo
    logo_file_name
  end

  def logo?
    logo_file_name.present?
  end

  def banner
    banner_file_name
  end

  def banner?
    banner_file_name.present?
  end

	# has_attached_file :logo,
 #    storage: :s3,
 #    s3_credentials: "#{Rails.root}/config/s3.yml",
 #    s3_permissions: "public-read",
 #    path: "home_logo_banners/:id/:filename",
 #    bucket: "passmrcs-production"

 #   has_attached_file :banner,
 #    storage: :s3,
 #    s3_credentials: "#{Rails.root}/config/s3.yml",
 #    s3_permissions: "public-read",
 #    path: "home_logo_banners/:id/:filename",
 #    bucket: "passmrcs-production"
end
