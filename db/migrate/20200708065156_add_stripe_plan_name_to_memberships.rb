class AddStripePlanNameToMemberships < ActiveRecord::Migration[6.0]
  def change
    add_column :memberships, :stripe_plan_name, :string, limit: 255
    begin
    	Membership.all.each do |membership|
		    if membership.id == 3
		      membership.update(stripe_plan_name: ENV['STRIPE_PLAN_299'])
		    elsif membership.id == 2        
		      membership.update(stripe_plan_name: ENV['STRIPE_PLAN_189'])
		    elsif membership.id == 1  
		      membership.update(stripe_plan_name: ENV['STRIPE_PLAN_115'])  
		    else
		      membership.update(stripe_plan_name: ENV['STRIPE_PLAN_115'])  		    	
		    end
			end
    rescue Exception => e
    	
    end
  end
end
