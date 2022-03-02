# == Schema Information
#
# Table name: memberships
#
#  id         :integer          not null, primary key
#  length     :integer
#  price      :decimal(8, 2)
#  available  :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Membership < ApplicationRecord
  STATUS_OPTIONS = %w(create renewal)

  validates :length, :price, presence: true
  validates :length, :price, presence: true
  validates :status, :inclusion => {:in => STATUS_OPTIONS}

  has_many :users

  scope :available, -> { where(available: true) }
  scope :on_create, -> { where(status: STATUS_OPTIONS[0]) }
  scope :on_renewal, -> { where(status: STATUS_OPTIONS[1]) }
  after_create :set_stripe_price
  after_update :update_stripe_price
  default_scope { where(available: true) }

  def to_s
    "£#{price.to_i} for #{length} months"
  end

 def price_cents
    price.to_i * 100
  end
  # def to_s
  #   "#{price.to_i} pounds for #{length} months"
  # end

  def name
    to_s
  end

  def set_stripe_price
    begin    
      sku = Stripe::SKU.create({
          attributes: {name: "Pass the MRCS Premium Membership for #{length} months"},
          price: price_cents,
          currency: 'gbp',
          inventory: {type: 'infinite', quantity: nil},
          product: ENV['STRIPE_PRODUCT_ID'],
        })
      puts "sku created: #{sku}"
      self.stripe_plan_name = sku.id
      self.save
    rescue Exception => e
      puts "Error #{e}"
    end
  end

  def update_stripe_price
    begin
      if stripe_plan_name.blank?
        set_stripe_price
      else
        stripe_sku = Stripe::SKU.update(
          stripe_plan_name,
          {price: price_cents},
        )
        puts "Sku updated: #{stripe_sku}"
      end
    rescue Exception => e
      puts "Error #{e}"
    end    
  end
end
