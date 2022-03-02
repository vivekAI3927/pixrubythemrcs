class ChangeUserCountryNameToCountryCode < ActiveRecord::Migration[6.0]
  def up
		User.all.each do |data|
		  if data.country && data.country.length > 2
		    country_code = ISO3166::Country.find_country_by_name(data.country).alpha2
		    data.country = country_code
		    data.save(:validate => false)
		  end  
		end
	end
	
	def down
	end 
end
