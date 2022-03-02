Rails.application.routes.draw do
  
  devise_for :users,
              controllers: {
                sessions: "sessions",
                registrations: "registrations"
              }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   root :to => "home#index"
   get '/faq' => 'home#faq', as: :faq
   get '/partners' => 'home#partner', as: :partner
   get "gocardless/index"

  # static public pages
  # match 'about-us' => "home#about_us", as: :about_us,via: [:get, :post]
  match 'courses' => "home#courses", as: :courses,via: [:get, :post]
  match 'trial' => "home#trial", as: :trial,via: [:get, :post]
  match 'terms-and-conditions' => "home#terms", as: :terms,via: [:get, :post]
  match 'terms-and-privacy' => "home#privacy", as: :privacy,via: [:get, :post]
  match 'community_code' => "home#community_code", as: :community_code,via: [:get, :post]
  match 'end_user_license_agreement' => "home#end_user_license_agreement", as: :end_user_license_agreement,via: [:get, :post]
  match 'cookie_policies' => "home#cookie_policies", as: :cookie_policies,via: [:get, :post]
  match 'disclaimer' => "home#disclaimer", as: :disclaimer,via: [:get, :post]
  match 'footer' => "home#footer", as: :footer,via: [:get, :post]
  match 'books' => "home#books", as: :books,via: [:get, :post]
  match 'acland' => "home#anatomy", as: :anatomy,via: [:get, :post]
  match 'mock-exams' => "home#mock_exams", as: :mock_exams,via: [:get, :post]
  match 'progress' => "home#progress", as: :progress,via: [:get, :post]
  match 'feedback' => "home#feedback", as: :feedback,via: [:get, :post]
  match 'coaching' => "home#coaching", as: :coaching,via: [:get, :post]
  match 'open_resource_modal' => "home#open_resource_modal", as: :open_resource_modal,via: [:get, :post]
  match 'open_course_modal' => "home#open_course_modal", as: :open_course_modal,via: [:get, :post]
  match 'parta_registration_complete' => "home#parta_registration_complete", as: :parta_registration_complete,via: [:get, :post]

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

  resources :users do
    resources :memberships
    member do
      get 'start_payment', to: 'gocardless#index'
      post 'submit_payment', to: "gocardless#submit"
      post 'apply_coupon', to: "gocardless#apply_coupon", as: :apply_coupon
      resources :stripe_payments, only: :create
    end
    
  end
  # get '/recommend', to: 'users#recommend'
  # post 'recommends', to: 'recommends#create'

  resources 'surveys'
  resources 'attempts'
  delete 'attempts/:survey_id/:user_id' => 'attempts#delete_user_attempts', as: :delete_user_attempts

  # resources :sessions
  resources :password_resets

  resources :ratings
  resources :categories
  resources :stations, only: :show do
    member do
      get 'toggle_attempt'
      get 'update_status'
    end
    resources :questions
  end

  resources :exams do
    member do
      get 'next_station', to: 'exams#next_station'
      get 'review', to: 'exams#review'
    end
    resources :stations do
      resources :questions
    end
  end

  # GoCardless Callbacks
  get 'gocardless/confirm', as: 'payment_confirm'
  get '/success' => 'gocardless#success' , as: 'payment_success'
  get '/canceled' => 'gocardless#canceled' , as: 'payment_canceled'
  post '/stripe_events' => 'gocardless#stripe_events' , as: 'payment_stripe_events'
  # Paypal processing of IPN callback
  resources :paypal_payment_notifications
   get '/about_us' => 'home#about_us', as: :about_us

   #Admin Routes
    get '/admin/users/get_filter_user_list' => 'admin/users/get_filter_user_list'#, as: 'admin_users'
    get 'admin/stations/get_filter_station' => 'admin/stations/get_filter_station'
    get 'admin/questions/get_filter_question' => 'admin/questions/get_filter_question'
    get 'admin/courses/get_filter_course' => 'admin/courses/get_filter_course'
    get 'admin/coachings/get_filter_course' => 'admin/coachings/get_filter_course'
    get 'admin/exams/get_filter_exam' => 'admin/exams/get_filter_exam'
    get 'admin/ratings/get_filter_rating' => 'admin/ratings/get_filter_rating'
    get 'admin/testimonials/get_filter_testimonial' => 'admin/testimonials/get_filter_testimonial'
    get 'admin/books/get_filter_book' => 'admin/books/get_filter_book'
    get 'admin/attempts/get_filter_attempt' => 'admin/attempts/get_filter_attempt'
    get 'admin/admins/get_filter_admin_user' => 'admin/admins/get_filter_admin_user'
    get 'admin/settings/get_filter_setting' => 'admin/settings/get_filter_setting'
    get 'admin/prices/get_filter_price' => 'admin/prices/get_filter_price'
    get 'admin/users/download_csv' => 'admin/users/download_csv'

  devise_for :admins, skip: [:registrations]
  
	devise_for :parta_users
 

  namespace :admin do
    root to: "dashboard#index"
    resources :users do
      post 'exam_reminder', to: 'users#exam_reminder'
      post 'not_join_message', to: 'users#not_join_message'
      post 'paid_message', to: 'users#paid_message'
      get 'download_pdf', to: 'users#download_pdf'

      # get 'download_csv', to: 'users#download_csv'
    end
    get 'active_users', to: 'users#active_user'
    get 'recent_lapse_users', to: 'users#recent_lapse_user'
    get 'lapse_users', to: 'users#lapse_user'
    get 'sale_leads_users', to: 'users#sale_leads_user'
    get 'not_subscribed_users', to: 'users#not_subscribed_user'  

		resources :parta_users
    resources :admins do
      get 'download_pdf', to: 'admins#download_pdf'
      resources :admin_accesses
    end  
    resources :categories
    resources :answers do
      get 'download_pdf', to: 'coupons#download_pdf'
    end  
    resources :questions do
      get 'detail', to: 'questions#question_detail'
      get 'download_pdf', to: 'questions#download_pdf'
      get 'move_up', to: 'questions#move_up'
      get 'move_down', to: 'questions#move_down'
      delete 'destroy_question' => 'questions#destroy_question'
    end  
    resources :exams
    resources :ratings do
      get 'download_pdf', to: 'ratings#download_pdf'
    end  
    resources :stations
    resources :teams 
    resources :testimonials do
      get 'download_pdf', to: 'testimonials#download_pdf'
    end  
    resources :courses
    resources :coachings
    resources :books
    resources :attempts
    resources :coupons
    resources :memberships
    resources :settings do
      get 'download_pdf', to: 'settings#download_pdf'
    end  
    resources :prices
    resources :privacy_terms
    resources :faqs
    resources :resources
    resources :feedbacks do
      get 'download_pdf', to: 'feedbacks#download_pdf'
    end  
    resources :home_logo_banners do
      get 'download_pdf', to: 'home_logo_banners#download_pdf'
    end
    resources :abouts 
    resources :member_home_pages
    resources :mock_exams 
    resources :full_term_conditions
    resources :footer_records
    resources :email_formats
    resources :question_categories
    resources :target_specialities
    resources :payment_contents
    resources :member_feedbacks
    # resources :reset_password_emails
    resources :user_join_emails
    resources :community_codes
    resources :end_user_license_agreements
    resources :cookie_policies
    resources :disclaimers
    resources :mock_exam_texts
    resources :partners
    resources :partner_members
    resources :about_us_images
		resources :parta_infos
    namespace :parta do
      resources :categories
      resources :settings
      resources :questions do
          get 'detail', to: 'questions#question_detail'
          get 'download_pdf', to: 'questions#download_pdf'
          get 'move_up', to: 'questions#move_up'
          get 'move_down', to: 'questions#move_down'
          delete 'destroy_question' => 'questions#destroy_question'
        end 
    end
  end

  resources :admins do
    resources :comments, module: :admins
  end
  resources :users do
    resource :comments, module: :users
  end

  namespace :parta do
    root :to => "home#parta_registration_complete"
    # root :to => "categories#index"
    resources :answers_options
    resources :practice_answers  
    resources :categories, only: :show do
      member do
        get 'toggle_attempt'
        get 'parta_update_status'
        get 'parta_cat_update_status'
      end
      resources :questions do
        delete 'destroy_question' => 'questions#destroy_question'
        get 'move_up', to: 'questions#move_up'
        get 'move_down', to: 'questions#move_down'
        get 'practice_all_question', to: 'practices#practice_all_question'
      end
        get 'practice_all', to: 'practices#practice_all'
    end
  end


  get 'parta/categories/:category_id/questions/:question_id/answers_options/:answers_option_id/reset_answer' => 'parta/answers_options#reset_answer', as: :parta_category_question_answer_option
  get 'parta/categories/:category_id/questions/:question_id/answers_options/:answers_option_id/practice_reset_answer' => 'parta/practice_answers#reset_answer', as: :parta_category_question_practice_answer

end
