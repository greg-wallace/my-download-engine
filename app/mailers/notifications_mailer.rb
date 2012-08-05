class NotificationsMailer < ActionMailer::Base

  default :from => "heroku@icodeforu.com"
  default :to => "greg@icodeforu.com"

  def new_message(message)
    @message = message
    mail(:subject => "[icodeforu] #{message.subject}")
  end

end