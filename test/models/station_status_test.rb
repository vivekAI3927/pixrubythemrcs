# == Schema Information
#
# Table name: station_statuses
#
#  id         :bigint           not null, primary key
#  user_id    :integer
#  station_id :integer
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class StationStatusTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
