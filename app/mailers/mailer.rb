class Mailer < ActionMailer::Base
  default from: "info@vizibid.com"

  def feedback_email(user, subject, message)
  	@user = user
  	@subject = subject
  	@message = message

  	mail(:to => "marc@vizibid.com, forrest@vizibid.com", :subject => "New Feedback Received")
  end

  def inappropriate_document_email(user, form, reason)

  	@user = user
  	@form = form
    @reason = reason

  	mail(:to => "marc@vizibid.com, forrest@vizibid.com", :subject => "Inappropriate document reported")
  end

  def inappropriate_request_email(user, request, reason)

    @user = user
    @request = request
    @reason = reason
    
    mail(:to => "marc@vizibid.com, forrest@vizibid.com", :subject => "Inappropriate request reported")
  end

  def password_reset(user)
    @user = user
    mail(:to => user.email, :subject => "Password Reset")
  end

  def user_verification_email(user, emailaddress)
    @user = user
    mail(emailaddress, :subject => "Vizibid Verification")
  end

end
