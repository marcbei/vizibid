ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "vizivid.com",
  :user_name            => "marc",
  :password             => "sub81mit",
  :authentication       => "plain",
  :enable_starttls_auto => true
}