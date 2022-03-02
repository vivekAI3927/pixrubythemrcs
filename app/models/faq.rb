# == Schema Information
#
# Table name: faqs
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  status      :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  rank        :integer
#
class Faq < ApplicationRecord

	default_scope { order('rank ASC') }

	validates :title, presence: true
  validates_length_of :title, :maximum => 255
  validates :description, presence: true
end
