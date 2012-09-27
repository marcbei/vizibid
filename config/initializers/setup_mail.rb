ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "vizivid.com",
  :user_name            => "marc",
  :password             => ENV['MAIL_PASSWORD'],
  :authentication       => "plain",
  :enable_starttls_auto => true
}

config.action_mailer.raise_delivery_errors = true