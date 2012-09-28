class Mailer < ActionMailer::Base
  default from: "info@vizibid.com"

  def feedback_email(user, subject, message)
  	@user = user
  	@subject = subject
  	@message = message

  	mail(:to => "marc@vizibid.com, forrest@vizibid.com", :subject => "New Feedback Received")
  end

  def inappropriate_document_email(user, form)

  	@user = user
  	@form = form

  	mail(:to => "marc@vizibid.com, forrest@vizibid.com", :subject => "Inappropriate document reported")
  end

end
