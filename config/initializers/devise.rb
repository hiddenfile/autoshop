Devise.setup do |config|
  # ==> Mailer Configuration
  config.mailer_sender = "please-change-me-at-config-initializers-devise@example.com"

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [ :email ]

  config.stretches = 10

  config.use_salt_as_remember_token = true

  config.reset_password_within = 2.hours
end
