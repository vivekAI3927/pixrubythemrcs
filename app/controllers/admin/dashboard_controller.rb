# frozen_string_literal: true

class Admin::DashboardController < Admin::BaseController
  def index
   	@active_users_data = []
   	@recent_lapse_users_data = []
   	@lapse_users_data = []
   	@sale_leads_users_data = []
   	@not_subscribed_users_data = []
    User.all.includes(:membership).each do |user|
      membership_length = user.membership.length rescue nil
      start_time = user.subscribed_on rescue nil
      end_time = start_time + membership_length.month rescue nil
      inside = Date.today
      active_user = inside.between?(start_time, end_time) rescue nil

      end_membership_last_4_week = inside - 4.weeks rescue nil
      one_day_before_today_date =  inside - 1.day
      recent_lapse = end_time.between?(end_membership_last_4_week, one_day_before_today_date) rescue nil

      laspe = end_time < end_membership_last_4_week rescue nil

      user_created_date = user.created_at.to_date
      user_created_date_last_3_month = Date.today - 3.month
      user_suscribed_date = user.subscribed_on
      not_suscribe_but_regis_last_3_month = user_created_date.between?(user_created_date_last_3_month, Date.today) rescue nil

      not_suscribed = user_created_date <  user_created_date_last_3_month rescue nil

      if active_user == true
        @active_users_data << [user.id]
      end

      if recent_lapse == true
        @recent_lapse_users_data << [user.id]
      end

      if laspe == true
        @lapse_users_data << [user.id]
      end

      if (user_suscribed_date == nil) && (not_suscribe_but_regis_last_3_month == true)
      	@sale_leads_users_data << [user.id]
      end	

      if (user_suscribed_date == nil) && (not_suscribed == true)
      	@not_subscribed_users_data << [user.id]
      end	
    end
  end
end
