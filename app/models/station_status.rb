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
class StationStatus < ApplicationRecord
	belongs_to :station
	belongs_to :user

	def todo
		status == STATION_TODO
	end

	def flagged
		status == STATION_FLAGGED
	end

	def done
		status == STATION_DONE
	end

end
