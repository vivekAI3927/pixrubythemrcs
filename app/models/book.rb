# == Schema Information
#
# Table name: books
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  description        :text
#  link               :string(255)
#  cost               :decimal(, )
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  available          :boolean          default(TRUE)
#

class Book < ApplicationRecord

  scope :available, -> { where(available: true) }

  validates :name, :description, :cost, :link, presence: true
  validates_length_of :name, :maximum => 255
  validates_length_of :link, :maximum => 255
  mount_uploader :image_file_name, BookImageUploader

  # has_attached_file :image,
  #   storage: :s3,
  #   s3_credentials: "#{Rails.root}/config/s3.yml",
  #   s3_permissions: "public-read",
  #   path: "books/:id/:filename",
  #   bucket: "passmrcs-production"

  def image
    image_file_name
  end

  def image?
    image_file_name.present?
  end

  def paypal_url(return_url)
    values= {
      business: BUSSINESS_EMAIL,
      cmd: '_cart',
      upload: '1',
      return: return_url,
      invoice: id,
      currency_code: CURRENCY,
      amount_1: self.cost,
      item_name_1: self.name,
      item_number_1: self.id,
      quantity_1: '1'
    }

    PAYPAL_URL + values.map { |k,v| "#{k}=#{v}"}.join("&")
  end
end
