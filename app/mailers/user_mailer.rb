class UserMailer < ApplicationMailer

  default from: CONTACT_EMAIL
  default cc: CONTACT_EMAIL

  def registration_message(user)
    @user_join_email = UserJoinEmail.last
    mail to: user.email, subject: @user_join_email.present? ? @user_join_email.subject : "Welcome Email"
  end

  def paid_message(user)
    mail to: user.email, subject: t('mailers.users.paid_message_subject')
  end

  def exam_reminder(user)
    mail to: user.email, subject: t('mailers.users.exam_reminder_subject')
  end

  def not_join_message(user)
    mail to: user.email, subject: t('mailers.users.not_join_message_subject')
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: t('mailers.users.password_reset_subject')
  end

  def recommend_email(email, description)
    @email = email
    @description = description
    mail to: email, subject: t('mailers.users.recommend_email_subject')
  end
  
  def parta_registration_message(user)
		parta_info =  PartaInfo.where(:area_tag => AREA_TAG_PARTA_USER_JOIN_EMAIL).first
		if parta_info
			@msg_body = parta_info.body_info.present? ? parta_info.body_info : 'Thanks for showing interest for Part A Exam.'
			mail to: user.email, subject: parta_info.heading_info.present? ? parta_info.heading_info : "Welcome Email"
		end
  end
	
end
