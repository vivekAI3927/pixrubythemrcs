# == Schema Information
#
# Table name: recommends
#
#  id          :integer          not null, primary key
#  email       :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string(255)
#
class Recommend < ApplicationRecord
end
