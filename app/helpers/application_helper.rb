module ApplicationHelper

	def current_class?(active_url)
    request.path == active_url ? ACTIVE : ''
  end 


  def is_active_controller(controller_name, class_name = nil)
        # return active class
        if params[:controller] == controller_name
         class_name == nil ? ACTIVE : class_name
        else
           nil
        end
    end

     def is_active_action(action_name)
        params[:action] == action_name ? ACTIVE : nil
    end

  #  Retunn desired flash message class
  def flash_class(level)
    case level
    when NOTICE then "#{ALERT} alert-info"
    when SUCCESS then "#{ALERT} alert-success"
    when ERR then "#{ALERT} alert-danger"
    when ALERT then "#{ALERT} alert-danger"
    end
  end

  def build_flash model
		if model.errors.count > 0
		  flash.now[:alert] = model.errors.full_messages.join('<br/>').html_safe
		end
	end

  def correct_flash_name name
    case name
    when ALERT
      DANGER
    when NOTICE
      SUCCESS
    else
      name
    end
  end

  def is_active?(link_path)
    current_page?(link_path) ? ACTIVE : nil
  end

  def user_form
    common_options = { validate: true, html: { class: 'user-form' } }
    form_options = current_user ? [ current_user, { url: change_user_name_path(current_user.id), method: :post, validate: true }.merge(common_options) ] : [ User.new, { validate: true }.merge(common_options) ]
    form_for *form_options do |f|
      yield f
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == ASC ? DESC : ASC
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end


  def royal_colleges
    if RoyalCollege.count > 0 
      return RoyalCollege.all.map{|college| [college.name, college.id]}
    else
      royal_college = RoyalCollege.create(name: 'England')
      return royal_college.split
    end
  end

  private
  
  def number_of_people_who_also_answered_count option_id
    Survey::Answer.where(option_id: option_id).count
  end
end

