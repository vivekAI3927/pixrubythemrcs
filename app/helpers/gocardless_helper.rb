module GocardlessHelper
  def membership_duration(user)
  	# return membership duration
    duration = user.membership.length
    return " for a #{duration} month membership"
  end
end
