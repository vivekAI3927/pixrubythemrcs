class Parta::Category < ApplicationRecord
	  extend FriendlyId
  # attr_accessor :available

  validates :name, presence: true
  validates_length_of :name, :maximum => 255
  # validates :description, presence: true
  # validates :position, presence: true


  default_scope { order(:position) }
  scope :level_1, -> { where(parta_category_id: 
    nil)}

  friendly_id :name, use: :slugged

  mount_uploader :image, PartaCategoryUploader

	has_many :childrens, :class_name => "Parta::Category", foreign_key: 'parta_category_id'
  belongs_to :parent, :class_name => "Parta::Category", foreign_key: 'parta_category_id', :optional => true
  has_many :questions, :class_name => "Parta::Question", foreign_key: 'parta_category_id'
  has_many :parta_category_statuses, :class_name => "Parta::CategoryStatus", foreign_key: 'parta_category_id'
  # has_many :category_statuses, :dependent => :delete_all
# 

  def parta_update_status(current_parta_user, flag=CATEGORY_TODO)
    parta_category_status ||= Parta::CategoryStatus.find_or_initialize_by(parta_user_id: current_parta_user.id, parta_category_id: self.id)
    parta_category_status.status = flag
    parta_category_status.save
    parta_category_status
  end

  def parta_category_status(current_parta_user)
    parta_category_status ||= Parta::CategoryStatus.where(parta_user_id: current_parta_user.id, parta_category_id: self.id).first
    if parta_category_status.blank?
      parta_category_status = self.parta_update_status(current_parta_user, CATEGORY_TODO)
    end
      parta_category_status  
  end

  def parta_cat_update_status(current_parta_user, flag=CATEGORY_TODO)
    parta_cat_category_status ||= Parta::CategoryStatus.find_or_initialize_by(parta_user_id: current_parta_user.id, parta_category_id: self.id)
    parta_cat_category_status.status = flag
    parta_cat_category_status.save
    parta_cat_category_status
  end

  def parta_cat_category_status(current_parta_user)
    parta_cat_category_status ||= Parta::CategoryStatus.where(parta_user_id: current_parta_user.id, parta_category_id: self.id).first
    if parta_cat_category_status.blank?
      parta_cat_category_status = self.parta_cat_update_status(current_parta_user, CATEGORY_TODO)
    end
      parta_cat_category_status  
  end

  def self.generate_random_stations(name, number)
    childrens = self.where("name = ?", name.to_s).first.childrens.sample(number).map { |station| station.id}
  end

  def first_question
    self.questions.first
  end

  def self.delay_add_attamps(user_id)
    stations_hash = []
    Station.available.each do |station|
      # Attempt.create(station_id: station.id, user_id: user_id)
      stations_hash << {station_id: station.id, user_id: user_id, created_at: Time.now, updated_at: Time.now}
    end
    Attempt.insert_all(stations_hash) if stations_hash.present?
  end

  def correct_ans_percentage(category_id, user_id)
    # calculate user station percentage
    # if category_id.present?
      questions = self.questions rescue nil
      questions_ids = questions.order("id ASC").map(&:id) rescue nil
      # Parta::AnswersOption
      percentage_hash = []
      questions.order("id ASC").each do |quest|
        @question = Parta::Question.find_by(id: quest)
        answers = @question.answers
        correct_answer = @question.answers.where(correct: true).last
        attempt_question = Parta::AnswersOption.where(question_id: quest, user_id: user_id, answer_id: correct_answer.id).last rescue nil
          # if (correct_answer.id == attempt_question.last.answer_id)
            
          # end 
          percentage_hash << attempt_question
      end
      @attempt_questions = percentage_hash.reject! { |x| x.nil? }
      @all_attempt = Parta::AnswersOption.where(question_id: questions_ids, user_id: user_id) rescue nil
      # return 0 if @all_attempt.count == 0
      @attempts = Parta::AnswersOption.where(question_id: questions_ids, user_id: user_id) rescue nil
      # @percentage = ((@attempts.count.to_f / @all_attempt.count.to_f)*100).to_i
      @percentage = ((@attempt_questions.count.to_f / @all_attempt.count.to_f)*100).to_i rescue nil
    # end  
  end

  def practice_correct_ans_percentage(category_id, user_id, question_id, question_type)
    @all_questions_ids = Parta::Question.all.map(&:id)
    active_user_attempts = Parta::AnswersOption.all.where(user_id: user_id)
    @all_attempt_question_ids = active_user_attempts.all.map(&:question_id)
    if (question_type == "new_question")
      questions_ids = @all_questions_ids - @all_attempt_question_ids
    elsif (question_type == "marked_incorrect")
      @incorrect_question = []
      @all_attempt_question_ids.each do |attempt_question|
        @question = Parta::Question.find_by(id: attempt_question)
        @correct_answer = @question.answers.where(correct: true).last
        @correct_attempt_question = Parta::AnswersOption.where(question_id: @question.id, answer_id: @correct_answer.id, user_id: user_id).last rescue nil
        if !@correct_attempt_question.present?
          @incorrect_question << @question
        end  
      end
      questions_ids = @incorrect_question.sort.map(&:id)
    end  
    percentage_hash = []
    questions_ids.each do |quest|
      @question = Parta::Question.find_by(id: quest)
      answers = @question.answers
      correct_answer = @question.answers.where(correct: true).last
      attempt_question = Parta::PracticeAnswer.where(question_id: quest, user_id: user_id, answer_id: correct_answer.id).last rescue nil
      percentage_hash << attempt_question
    end
    @attempt_questions = percentage_hash.reject! { |x| x.nil? }
    @all_attempt = Parta::PracticeAnswer.where(question_id: questions_ids, user_id: user_id) rescue nil
    @attempts = Parta::PracticeAnswer.where(question_id: questions_ids, user_id: user_id) rescue nil
    @percentage = ((@attempt_questions.count.to_f / @all_attempt.count.to_f)*100).to_i rescue nil
  end

  def percentage(category_id, user_id)
    # calculate user station percentage
    childrens = self.childrens
    childrens_ids = childrens.map(&:id)
    @all_attempt = Parta::Attempt.where(parta_category_id: childrens_ids, user_id: user_id)
    return 0 if @all_attempt.count == 0
    @attempts = Parta::Attempt.where(parta_category_id: childrens_ids, started: true, completed: true, user_id: user_id)
    @percentage = ((@attempts.count.to_f / @all_attempt.count.to_f)*100).to_i
  end

  # def update_status(current_user, flag=STATION_TODO)
  #   station_status ||= StationStatus.find_or_initialize_by(user_id: current_user.id, station_id: self.id)
  #   station_status.status = flag
  #   station_status.save
  #   station_status
  # end

  # def station_status(current_user)
  #   station_status ||= StationStatus.where(user_id: current_user.id, station_id: self.id).first
  #   if station_status.blank?
  #     station_status = self.update_status(current_user, STATION_TODO)
  #   end
  #     station_status  
  # end
end
