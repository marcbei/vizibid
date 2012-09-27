ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "vizibid.com",
  :user_name            => "info@vizibid.com",
  :password             => ENV['INFO_ACCOUNT_PASSWORD'],
  :authentication       => "plain",
  :enable_starttls_auto => true
}