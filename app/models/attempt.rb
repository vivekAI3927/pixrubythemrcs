# == Schema Information
#
# Table name: attempts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  station_id :integer
#  started    :boolean          default(FALSE)
#  completed  :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :station

  def user_toggle
    # update station attempts flag
    if !started
      self.update_attribute(:started, true)
    elsif started && !completed
      self.update_attribute(:completed, true)
    elsif started && completed
      self.update_attributes({started: false, completed: false})
    end
  end
end
