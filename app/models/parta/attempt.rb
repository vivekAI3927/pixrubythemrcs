class Parta::Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :parta_category, :class_name => "Parta::Category", foreign_key: 'parta_category_id', :optional => true

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
