class Mailer < ActionMailer::Base
  default from: "marc@vizibid.com"

  def feedback_email(user, subject, message)
  	@user = user
  	@subject = subject
  	@message = message

  	mail(:to => "marc@vizibid.com", :subject => "New Feedback Received")

  end

end
