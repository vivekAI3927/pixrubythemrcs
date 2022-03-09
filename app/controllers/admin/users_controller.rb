class Admin::UsersController < Admin::BaseController
  # before_action :check_if_admin, only: [:destroy]
  before_action :set_admin_access
  skip_before_action :is_membership_subscribed?

  # def index
  #   @users = User.all.paginate(page: params[:page], per_page: 30)

  # end
  helper_method :sort_column, :sort_direction

  def index
    if params[:search_name].present? && !params[:search_email].present?
      @parameter = params[:search_name].downcase  
      @users = User.all.where("lower(name) LIKE :search", search: "%#{@parameter}%").paginate(:page => params[:page], :per_page => 100) 
    elsif !params[:search_name].present? && params[:search_email].present?
      @parameter = params[:search_email].downcase 
      @users = User.all.where("lower(email) LIKE :search", search: "%#{@parameter}%").paginate(:page => params[:page], :per_page => 100)
    elsif params[:search_name].present? && params[:search_email].present?
      @users = User.where("name LIKE ? OR email LIKE ?" ,"%#{params[:search_name].downcase}%", "%#{params[:search_email].downcase}%").paginate(:page => params[:page], :per_page => 100)
    elsif params[:sort].present?
      @users = User.all.where(["name LIKE (?) or email=?","%#{params[:search]}%",params[:search]]).paginate(:page => params[:page], :per_page => 100).order(sort_column + " " + sort_direction)  
    else
      @users = User.all.where(["name LIKE (?) or email=?","%#{params[:search]}%",params[:search]]).paginate(:page => params[:page], :per_page => 100).order("created_at DESC")
    end    
  end

  def download_csv
    @users = User.all.order("name ASC")
    csv_string = CSV.generate do |csv|
         csv << ["Id", "Name", "Email", "Status", "Membership","Target Speciality", "Encrypted Password", "Created at", "Updated at", "Password Reset Token", "Password Reset Sent at", "Subscribed on", "Referred by", "Coupon Name", "Country", "Sent Exam Reminder", "Target Exam Date", "Authentication Token", "Reset Password Token", "Reset Password Sent at", "Current Sign in at", "Last Sign in at", "Current Sign in ip", "Last Sign in ip", "Remember Created at"]
         @users.each do |user|

          membership_length = user.membership.length rescue nil
          start_time = user.subscribed_on
          end_time = start_time + membership_length.month rescue nil
          inside = Date.today
          active_user = inside.between?(start_time, end_time) rescue nil

          end_membership_last_4_week = inside - 4.weeks
          one_day_before_today_date =  inside - 1.day
          recent_lapse = end_time.between?(end_membership_last_4_week, one_day_before_today_date) rescue nil

          laspe = end_time < end_membership_last_4_week rescue nil

          user_created_date = user.created_at.to_date
          user_created_date_last_3_month = Date.today - 3.month
          user_suscribed_date = user.subscribed_on
          not_suscribe_but_regis_last_3_month = user_created_date.between?(user_created_date_last_3_month, Date.today)

          not_suscribed = user_created_date <  user_created_date_last_3_month

          if active_user == true
            status = "Active"
          elsif recent_lapse == true
            status = "Recent lapse"
          elsif laspe == true
            status = "Lapse"
          elsif (user_suscribed_date == nil) && (not_suscribe_but_regis_last_3_month == true)
            status = "Sale leads"
          elsif (user_suscribed_date == nil) && (not_suscribed == true)
            status = "Not subscribed"      
          end 
       csv << [user.id, user.name, user.email, status, user.membership.try(:name), user.target_speciality.try(:name), user.encrypted_password, user.created_at, user.updated_at, user.password_reset_token, user.password_reset_sent_at, user.subscribed_on, user.referred_by, user.coupon_name, user.country, user.sent_exam_reminder, user.target_exam_date, user.authentication_token, user.reset_password_token, user.reset_password_sent_at, user.current_sign_in_at, user.last_sign_in_at, user.current_sign_in_ip, user.last_sign_in_ip, user.remember_created_at]
     end
    end         
  
   send_data csv_string,
   :type => 'text/csv; charset=iso-8859-1; header=present',
   :disposition => "attachment; filename=users-#{Date.today}.csv" 

  end

  def get_filter_user_list
    if params[:country].present?
      country = params[:country]
      @users = User.all.where("country=?",country)
      @status = true
    elsif params[:target_exam_date].present? 
        target_exam_date = params[:target_exam_date]
        @users = User.all.where("target_exam_date =?",target_exam_date)
        @status = true
    else
      @status = false
    end
  end

  def download_pdf
    @user = User.find_by(id: params[:user_id])
    html = render_to_string(:action => 'download_pdf', :layout => false)
    pdf = PDFKit.new(html)
    send_data(pdf.to_pdf)
  end

  def new
    @user = User.new
  end

  def active_user
    @active_users_data = []
    User.all.each do |user|
      membership_length = user.membership.length rescue nil
      start_time = user.subscribed_on rescue nil
      end_time = start_time + membership_length.month rescue nil
      inside = Date.today
      active_user = inside.between?(start_time, end_time) rescue nil
      if active_user == true
        @active_users_data << user
      end
    end
  end

  def recent_lapse_user
    @recent_lapse_users_data = []
    User.all.includes(:membership).each do |user|
      membership_length = user.membership.length rescue nil
      start_time = user.subscribed_on rescue nil
      end_time = start_time + membership_length.month rescue nil
      inside = Date.today
      active_user = inside.between?(start_time, end_time) rescue nil

      end_membership_last_4_week = inside - 4.weeks rescue nil
      one_day_before_today_date =  inside - 1.day
      recent_lapse = end_time.between?(end_membership_last_4_week, one_day_before_today_date) rescue nil

      if recent_lapse == true
        @recent_lapse_users_data << user
      end
    end
  end

  def lapse_user
    @lapse_users_data = []
    User.all.includes(:membership).each do |user|
      membership_length = user.membership.length rescue nil
      start_time = user.subscribed_on rescue nil
      end_time = start_time + membership_length.month rescue nil
      inside = Date.today
      active_user = inside.between?(start_time, end_time) rescue nil
      end_membership_last_4_week = inside - 4.weeks rescue nil
      laspe = end_time < end_membership_last_4_week rescue nil

      if laspe == true
        @lapse_users_data << user
      end
    end
  end

  def sale_leads_user
    @sale_leads_users_data = []
    User.all.includes(:membership).each do |user|
      user_created_date = user.created_at.to_date
      user_created_date_last_3_month = Date.today - 3.month
      user_suscribed_date = user.subscribed_on
      not_suscribe_but_regis_last_3_month = user_created_date.between?(user_created_date_last_3_month, Date.today) rescue nil
      if (user_suscribed_date == nil) && (not_suscribe_but_regis_last_3_month == true)
        @sale_leads_users_data << user
      end  
    end
  end

  def not_subscribed_user
    @not_subscribed_users_data = []
    User.all.includes(:membership).each do |user|
      user_created_date = user.created_at.to_date
      user_created_date_last_3_month = Date.today - 3.month
      user_suscribed_date = user.subscribed_on
      not_suscribe_but_regis_last_3_month = user_created_date.between?(user_created_date_last_3_month, Date.today) rescue nil
      not_suscribed = user_created_date <  user_created_date_last_3_month rescue nil
      if (user_suscribed_date == nil) && (not_suscribed == true)
        @not_subscribed_users_data << user
      end 
    end  
  end  

  def create
    @user = User.new(user_params)
    if @user.save!
      # flash[:success] = "New user created."
      # MailerWorker.perform_async(@user.id)
      # UserMailer.welcome_email(@user).deliver
      redirect_to "/admin/users", notice: t('controllers.admin.users.create') 
    else
      render "new"
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if params[:user][:password].present?
      if (params[:user][:password] == params[:user][:password_confirmation])
        if @user.update(user_params)
          redirect_to "/admin/users/#{@user.id}", notice: t('controllers.admin.users.update') 
        else
          render "edit"
        end
      else
        render "edit"
      end 
    else  
      if @user.update(user_params)
        redirect_to "/admin/users/#{@user.id}", notice: t('controllers.admin.users.update') 
      else
        render "edit"
      end
    end  
  end

  def exam_reminder
    user = User.find(params[:user_id])
    user.send_exam_reminder
    redirect_to admin_users_path, notice: t('controllers.admin.users.exam_reminder')  
  end

  def not_join_message
    user = User.find(params[:user_id])
    user.send_not_join_message
    redirect_to admin_users_path, notice: t('controllers.admin.users.not_join_message')
  end

  def paid_message
    user = User.find(params[:user_id])
    user.send_paid_message
    redirect_to admin_users_path, notice: t('controllers.admin.users.paid_message')
  end

  def upload_image(text)
    @upload = {}
    @upload[:avatar] = Cloudinary::Uploader.upload(text)
    @avatar_url = @upload[:avatar]["url"]
  end

  def destroy
    user = User.find(params[:id])
    # authorize user
    if user
      user.destroy
      redirect_to "/admin/users", notice: t('controllers.admin.users.destroy') 
    else
      flash[:error] = "An error occured. Try deleting #{user.name} again."
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :membership_id, :target_exam_date, :country, :referred_by, :subscribed_on, :royal_college_id, :subscribed_expired_at)
  end

  def args_params
    args = params.require(:args).permit(:show_all, :name) if params.has_key? "args"
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
