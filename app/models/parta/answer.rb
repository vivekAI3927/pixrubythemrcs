class Parta::Answer < ApplicationRecord
  belongs_to :question, :class_name => "Parta::Question", foreign_key: 'parta_question_id', :optional => true

  validates :content, presence: true, allow_blank: false
end
