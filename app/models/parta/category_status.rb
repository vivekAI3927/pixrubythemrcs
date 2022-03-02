class Parta::CategoryStatus < ApplicationRecord

	# belongs_to :parta_category
	belongs_to :parta_category, :class_name => "Parta::Category", foreign_key: 'parta_category_id', :optional => true

	belongs_to :parta_user, :class_name => "Parta::User", foreign_key: 'parta_user_id', :optional => true

	def todo
		status == CATEGORY_TODO
	end

	def flagged
		status == CATEGORY_FLAGGED
	end

	def done
		status == CATEGORY_DONE
	end

end
