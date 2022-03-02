desc "This task update all subscription with subscribed_expired_at"
namespace :update_subscription do

	task :subscribed_expired_at => :environment do
	  puts 'update all subscription with subscribed_expired_at'
	  User.all.includes(:membership).each do |user|
	  	if user.subscribed_on && user.membership
		    puts "update subscription for user #{user.email}"
		    user.update_attributes(subscribed_expired_at: (user.subscribed_on + user.membership.length.months))
	    end
	  end
	end
end