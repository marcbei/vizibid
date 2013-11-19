class Mailer < ActionMailer::Base
  default from: "info@vizibid.com"

  def feedback_email(user, subject, message)
  	@user = user
  	@subject = subject
  	@message = message

  	mail(:to => "marc@vizibid.com, forrest@vizibid.com", :subject => "New Feedback Received")
  end

  def upload_failed_virus_scan_email(user, form)
    @user = user
    @form = form

    mail(:to => "marc@vizibid.com, forrest@vizibid.com", :subject => "Attempted upload failed virus scan")
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
    if !emailaddress.to_s.empty?
      mail(:to => "marc@vizibid.com", :bcc => ["marc@vizibid.com, forrest@vizibid.com"], :subject => "Vizibid Verification")
    else 
      @manual = true
      mail(:to => "marc@vizibid.com, forrest@vizibid.com", :subject => "Vizibid Verification")
    end
  end

  def doc_download_mail(user, form)
    @user = user
    @form = form
    mail(:to => user.email, :subject => "Thank you for your download")
  end

  def doc_comment_mail(current_user, rootform, formowner, comment)
    @currentuser = current_user
    @form = rootform
    @formowner = formowner
    @comment = comment

    mail(:to => @formowner.email, :subject => "New comment on your document")
  end

  def doc_request_mail(current_user, request, requestowner, request_submission)
    @currentuser = current_user
    @request = request
    @requestowner = requestowner
    @requestsubmission = request_submission

    mail(:to => @requestowner.email, :subject => "New submission on your document request")
  end

  def share_form_mail(user, shared_form)
    @shared_form = shared_form
    @currentuser = user
    @form = Form.find(shared_form.form_id)
    tmpfile = nil

     open(@form.form.url) {|form|
      tmpfile = Tempfile.new("temp#{@form.description}")
      File.open(tmpfile.path, 'wb') do |f| 
        f.write form.read
      end 
    }

    attachments[File.basename(@form.form.to_s.split('?')[0])] =  File.read(tmpfile.path)
    mail(:to => @shared_form.email_address, :subject => "Vizibid Form Shared With You")
  end

end
