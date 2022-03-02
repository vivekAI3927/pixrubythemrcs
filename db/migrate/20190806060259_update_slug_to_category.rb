class UpdateSlugToCategory < ActiveRecord::Migration[6.0]
  def up
  	Category.find_each(&:save)
  	Station.find_each(&:save)
  	Course.find_each(&:save)
  end

  def down
  end
end
