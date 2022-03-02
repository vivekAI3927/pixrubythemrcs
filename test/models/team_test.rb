# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  name       :string
#  title      :string
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  bio        :text
#  position   :integer
#
require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
