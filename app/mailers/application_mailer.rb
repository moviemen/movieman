class ApplicationMailer < ActionMailer::Base
  default from: Settings.action_mailer.email
  layout 'mailer'
end
