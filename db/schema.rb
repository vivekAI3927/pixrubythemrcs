# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_30_100203) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"

  create_table "about_us_images", force: :cascade do |t|
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "abouts", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
    t.string "image"
  end

  create_table "active_admin_comments", id: :integer, default: -> { "nextval('admin_notes_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "resource_id", limit: 255, null: false
    t.string "resource_type", limit: 255, null: false
    t.integer "author_id"
    t.string "author_type", limit: 255
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "namespace", limit: 255
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id"
  end

  create_table "admin_users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "editor", default: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "answers", id: :serial, force: :cascade do |t|
    t.integer "question_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name", limit: 255
    t.string "image_content_type", limit: 255
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "attempts", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "station_id"
    t.boolean "started", default: false
    t.boolean "completed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["station_id"], name: "index_attempts_on_station_id"
    t.index ["user_id"], name: "index_attempts_on_user_id"
  end

  create_table "books", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.text "description"
    t.string "link", limit: 255
    t.decimal "cost", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name", limit: 255
    t.string "image_content_type", limit: 255
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.boolean "available", default: true
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.text "advice"
    t.string "image_url", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name", limit: 255
    t.string "image_content_type", limit: 255
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.integer "position"
    t.string "slug", limit: 255
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.string "commentable_type"
    t.integer "commentable_id"
    t.integer "admin_id"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["commentable_id"], name: "index_comments_on_commentable_id"
  end

  create_table "community_codes", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cookie_policies", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "coupons", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "uses", default: 0
  end

  create_table "courses", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.text "description", null: false
    t.text "booking"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "available"
    t.string "image_file_name", limit: 255
    t.string "image_content_type", limit: 255
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "member_code", limit: 255
    t.string "slug", limit: 255
    t.index ["slug"], name: "index_courses_on_slug", unique: true
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by", limit: 255
    t.string "queue", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "disclaimers", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "email_formats", force: :cascade do |t|
    t.text "exam_reminder"
    t.text "not_join_message"
    t.text "paid_message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "end_user_license_agreements", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "exams", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "current_station"
    t.text "stations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_exams_on_user_id"
  end

  create_table "faqs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "rank"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.boolean "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.text "description"
    t.string "star_rating"
  end

  create_table "footer_records", force: :cascade do |t|
    t.string "copyright"
    t.string "all_right_reserved"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "full_term_conditions", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "home_logo_banners", force: :cascade do |t|
    t.text "description"
    t.string "logo"
    t.string "banner"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.integer "logo_file_size"
    t.datetime "logo_updated_at"
    t.string "banner_file_name"
    t.string "banner_content_type"
    t.integer "banner_file_size"
    t.datetime "banner_updated_at"
    t.string "first_title"
    t.string "second_title"
  end

  create_table "member_feedbacks", force: :cascade do |t|
    t.text "section_one"
    t.text "section_two"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "member_home_pages", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "memberships", id: :serial, force: :cascade do |t|
    t.integer "length"
    t.decimal "price", precision: 8, scale: 2
    t.boolean "available", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", limit: 255, default: "create"
    t.string "stripe_plan_name", limit: 255
  end

  create_table "mock_exam_texts", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "mock_exams", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
  end

  create_table "parta_answers", force: :cascade do |t|
    t.bigint "parta_question_id", null: false
    t.text "content"
    t.boolean "correct"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parta_question_id"], name: "index_parta_answers_on_parta_question_id"
  end

  create_table "parta_attempts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "parta_category_id", null: false
    t.boolean "started"
    t.boolean "completed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parta_category_id"], name: "index_parta_attempts_on_parta_category_id"
    t.index ["user_id"], name: "index_parta_attempts_on_user_id"
  end

  create_table "parta_categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "parta_category_id"
    t.string "image"
    t.integer "position"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parta_category_id"], name: "index_parta_categories_on_parta_category_id"
  end

  create_table "parta_infos", force: :cascade do |t|
    t.string "area_tag", limit: 63
    t.string "heading_info", limit: 255
    t.text "body_info"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "parta_questions", force: :cascade do |t|
    t.text "content"
    t.integer "position"
    t.integer "parta_category_id"
    t.string "image", limit: 255
    t.text "answer_text"
    t.string "image_text", limit: 255
    t.string "answer_image", limit: 255
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parta_category_id"], name: "index_questions_on_parta_category_id"
  end

  create_table "parta_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", limit: 255
    t.date "target_exam_date"
    t.string "country", limit: 255
    t.integer "target_speciality_id"
    t.index ["email"], name: "index_parta_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_parta_users_on_reset_password_token", unique: true
    t.index ["target_speciality_id"], name: "index_parta_users_on_target_speciality_id"
    t.index ["unlock_token"], name: "index_parta_users_on_unlock_token", unique: true
  end

  create_table "partner_members", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.string "image"
    t.text "bio"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "partners", force: :cascade do |t|
    t.text "description"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payment_contents", force: :cascade do |t|
    t.text "stripe"
    t.text "paypal"
    t.text "discount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "stripe_declaration"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "user_id"
    t.string "status", limit: 255
    t.string "provider", limit: 255
    t.json "response"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "prices", force: :cascade do |t|
    t.string "title"
    t.string "price"
    t.string "icon"
    t.boolean "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "privacy_terms", force: :cascade do |t|
    t.string "title"
    t.text "term_and_condition"
    t.text "note"
    t.boolean "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "question_categories", force: :cascade do |t|
    t.string "title"
    t.integer "no_of_question"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "questions", id: :serial, force: :cascade do |t|
    t.text "content"
    t.integer "position"
    t.integer "station_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name", limit: 255
    t.string "image_content_type", limit: 255
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.text "answer_text"
    t.string "answer_image_file_name", limit: 255
    t.string "answer_image_content_type", limit: 255
    t.integer "answer_image_file_size"
    t.datetime "answer_image_updated_at"
    t.string "image_text", limit: 255
    t.string "image_url", limit: 255
    t.string "answer_image_text", limit: 255
    t.string "answer_image_url", limit: 255
    t.index ["station_id"], name: "index_questions_on_station_id"
  end

  create_table "ratings", id: :serial, force: :cascade do |t|
    t.integer "question_id"
    t.integer "station_id"
    t.text "review"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_ratings_on_question_id"
    t.index ["station_id"], name: "index_ratings_on_station_id"
  end

  create_table "recommends", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", limit: 255
  end

  create_table "reset_password_emails", force: :cascade do |t|
    t.text "title"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "resources", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "available"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "settings", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slugs", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "sluggable_id"
    t.integer "sequence", default: 1, null: false
    t.string "sluggable_type", limit: 40
    t.string "scope", limit: 255
    t.datetime "created_at"
    t.index ["name", "sluggable_type", "sequence", "scope"], name: "index_slugs_on_n_s_s_and_s", unique: true
    t.index ["sluggable_id"], name: "index_slugs_on_sluggable_id"
  end

  create_table "station_statuses", force: :cascade do |t|
    t.integer "user_id"
    t.integer "station_id"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["station_id"], name: "index_station_statuses_on_station_id"
    t.index ["user_id"], name: "index_station_statuses_on_user_id"
  end

  create_table "stations", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.text "scenario_text"
    t.boolean "trial"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.text "markscheme"
    t.text "actor_brief"
    t.text "exam_brief"
    t.text "cheatsheet"
    t.string "image_file_name", limit: 255
    t.string "image_content_type", limit: 255
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "videoId", limit: 255
    t.boolean "available", default: true
    t.string "slug", limit: 255
    t.string "flag", default: "TO-DO"
    t.index ["category_id"], name: "index_stations_on_category_id"
    t.index ["slug"], name: "index_stations_on_slug", unique: true
  end

  create_table "survey_answers", id: :serial, force: :cascade do |t|
    t.integer "attempt_id"
    t.integer "question_id"
    t.integer "option_id"
    t.boolean "correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attempt_id"], name: "index_survey_answers_on_attempt_id"
    t.index ["option_id"], name: "index_survey_answers_on_option_id"
    t.index ["question_id"], name: "index_survey_answers_on_question_id"
  end

  create_table "survey_attempts", id: :serial, force: :cascade do |t|
    t.integer "participant_id"
    t.string "participant_type", limit: 255
    t.integer "survey_id"
    t.boolean "winner"
    t.integer "score"
    t.index ["participant_id"], name: "index_survey_attempts_on_participant_id"
    t.index ["survey_id"], name: "index_survey_attempts_on_survey_id"
  end

  create_table "survey_options", id: :serial, force: :cascade do |t|
    t.integer "question_id"
    t.integer "weight", default: 0
    t.string "text", limit: 255
    t.boolean "correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_survey_options_on_question_id"
  end

  create_table "survey_questions", id: :serial, force: :cascade do |t|
    t.integer "survey_id"
    t.string "text", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_survey_questions_on_survey_id"
  end

  create_table "survey_surveys", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.text "description"
    t.integer "attempts_number", default: 0
    t.boolean "finished", default: false
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "survey_type"
  end

  create_table "target_specialities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "bio"
    t.integer "position"
  end

  create_table "testimonials", id: :serial, force: :cascade do |t|
    t.string "author", limit: 255
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_join_emails", force: :cascade do |t|
    t.string "subject"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_memberships", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "membership_id"
    t.boolean "active"
    t.datetime "expired_at"
    t.string "token", limit: 255
    t.hstore "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["membership_id"], name: "index_user_memberships_on_membership_id"
    t.index ["user_id"], name: "index_user_memberships_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "email", limit: 255
    t.string "encrypted_password", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_reset_token", limit: 255
    t.datetime "password_reset_sent_at"
    t.date "subscribed_on"
    t.string "referred_by", limit: 255
    t.string "coupon_name", limit: 255
    t.string "country", limit: 255
    t.boolean "sent_exam_reminder", default: false
    t.integer "membership_id"
    t.integer "last_question_id"
    t.date "target_exam_date"
    t.string "authentication_token", limit: 255
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "remember_created_at"
    t.integer "target_speciality_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["membership_id"], name: "index_users_on_membership_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "parta_answers", "parta_questions"
  add_foreign_key "parta_attempts", "parta_categories"
  add_foreign_key "parta_attempts", "users"
  add_foreign_key "parta_users", "target_specialities", name: "fk_parta_users_target_speciality_id", on_delete: :nullify
  add_foreign_key "questions", "stations"
  add_foreign_key "station_statuses", "stations"
  add_foreign_key "station_statuses", "users"
  add_foreign_key "stations", "categories"
  add_foreign_key "survey_answers", "attempts"
  add_foreign_key "survey_answers", "questions"
  add_foreign_key "survey_options", "questions"
  add_foreign_key "user_memberships", "memberships"
  add_foreign_key "user_memberships", "users"
end
