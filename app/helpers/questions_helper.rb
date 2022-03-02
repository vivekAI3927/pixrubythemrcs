module QuestionsHelper

 def question_image_annotation(question)
  question = Question.find(question.id)
  if question.image_url?
    ("#{question.image_text} | " + link_to(question.image_url, question.image_url)).html_safe
  else  
    "#{question.image_text}"
  end
 end

 def answer_image_annotation(question)
  question = Question.find(question.id)
  if question.answer_image_url?
    ("#{question.answer_image_text} | " + link_to(question.answer_image_url, question.answer_image_url)).html_safe
  else  
    return "#{question.answer_image_text}"
  end
 end


end
