class Parta::Question < ApplicationRecord

	acts_as_list scope: :parta_category
  attr_accessor :delete_image
  attr_accessor :delete_answer_image


  belongs_to :parta_category, :class_name => "Parta::Category", foreign_key: 'parta_category_id', :optional => true
  validates :content, presence: true
  validates_length_of :content, :maximum => 255
  validates_length_of :image_text, :maximum => 255
  # validates :position, presence: true
  validates :answer_text, presence: true
  # validates_presence_of :content
  mount_uploader :image, PartaCategoryUploader

  mount_uploader :answer_image, PartaCategoryUploader
  has_many :answers, :dependent => :destroy, :class_name => "Parta::Answer", foreign_key: "parta_question_id"

  has_many :ratings
  accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

  # scope :next, lambda {|id| where("id > ?",id).order("id ASC") }

  def image?
    image.present?
  end
  
  def answer_image?
    answer_image.present?
  end
  def last?(category)
  	# station = Station.find_by_id(station.id)
  	self == category.questions.last ? true : false
  end

  def string_last?(category)
    # station = Station.find(station.id)
    self == category.questions.last ? "last" : "not last"
  end

  def penultimate?(category)
    # station = Station.find_by_id(station.id)
    # self == station.questions[-1] ? true : false
    self == category.questions.last ? true : false
  end

  def string_penultimate?(category)
    # station = Station.find_by_id(station.id)
    self == category.questions[-2] ? "penultimate" : "not penultimate"
  end

  # def next
  #   Parta::Question.where("parta_category_id = ? AND position = ?", self.parta_category_id, (self.position + 1)).first
  # end

  def next
    @category = Parta::Category.friendly.find(self.parta_category_id) rescue nil
    # order_list = @category.questions.select(:id).all.map(&:id)
    order_list = @category.questions.order("id ASC").select(:id).all.map(&:id)
    param_question = Parta::Question.find_by(id: self.id) rescue nil
    current_position = order_list.index(param_question.id) rescue nil
    @question = @category.questions.find(order_list[current_position + 1]) if order_list[current_position + 1] rescue nil
  end

  def next_practice_question(user, question_type)
    @all_questions_ids = Parta::Question.all.map(&:id)
    active_user_attempts = Parta::AnswersOption.all.where(user_id: user.id)
    @all_attempt_question_ids = active_user_attempts.all.map(&:question_id)
    @questions_ids = @all_questions_ids - @all_attempt_question_ids
    if question_type == "marked_incorrect"
      @incorrect_question = []
      @all_attempt_question_ids.each do |attempt_question|
        @question = Parta::Question.find_by(id: attempt_question)
        @correct_answer = @question.answers.where(correct: true).last
        @correct_attempt_question = Parta::AnswersOption.where(question_id: @question.id, answer_id: @correct_answer.id, user_id: user.id).last
        if !@correct_attempt_question.present?
          @incorrect_question << @question
        end  
      end
      @shorts_questions = @incorrect_question.sort
      question_ids = @shorts_questions.map(&:id)
      param_question = Parta::Question.find_by(id: self.id) rescue nil
      current_position = question_ids.index(param_question.id) rescue nil 
      @question = Parta::Question.find(question_ids[current_position + 1]) if question_ids[current_position + 1] rescue nil
    elsif question_type == "new_question"
      # shored_question_ids = @questions_ids.sort
      shored_question_ids = @questions_ids.sort.last(10)
      param_question = Parta::Question.find_by(id: self.id) rescue nil
      current_position = shored_question_ids.index(param_question.id) rescue nil 
      @question = Parta::Question.find(shored_question_ids[current_position + 1]) if shored_question_ids[current_position + 1] rescue nil
    end  
  end

  def practice_all_penultimate?(user, question_type)
    @all_questions_ids = Parta::Question.all.map(&:id)
    active_user_attempts = Parta::AnswersOption.all.where(user_id: user.id)
    @all_attempt_question_ids = active_user_attempts.all.map(&:question_id)
    @questions_ids = @all_questions_ids - @all_attempt_question_ids
    @return_data = []
    if question_type == "marked_incorrect"
      @incorrect_question = []
      @all_attempt_question_ids.each do |attempt_question|
        @question = Parta::Question.find_by(id: attempt_question)
        @correct_answer = @question.answers.where(correct: true).last
        @correct_attempt_question = Parta::AnswersOption.where(question_id: @question.id, answer_id: @correct_answer.id, user_id: user.id).last
        if !@correct_attempt_question.present?
          @incorrect_question << @question
        end  
      end
      @shorts_questions = @incorrect_question.sort.last(10)
      shored_question = @shorts_questions.map(&:id)
      param_question = Parta::Question.find_by(id: self.id) rescue nil
      @return_data << [self.id == shored_question.last ? true : false]
    elsif question_type == "new_question"
      shored_question = @questions_ids.sort.last(10)
      @return_data << [self.id == shored_question.last ? true : false]
    end
    @return_true_or_false = @return_data.last.last
    return @return_true_or_false
  end

  def to_s
    self.content
  end

  def remove_image
    self.image = nil
    self.save
  end

  def remove_answer_image
    self.answer_image = nil
    self.save
  end

  def move_up
    self.move_higher
  end

  def move_down
    self.move_lower
  end
end
