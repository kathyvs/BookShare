# Load the Rails application.
require_relative 'application'



ActionMailer::Base.smtp_settings = {
  :user_name => 'apikey',
  :password => ENV['SENDGRID_SMTP_PWD'],
  :domain => 'pennsic.kathyvs.net',
  :address => 'smtp.sendgrid.net',
  :test => ENV.keys.sort,
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}


# Initialize the Rails application.
Rails.application.initialize!
