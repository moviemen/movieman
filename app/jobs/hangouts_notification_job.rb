class HangoutsNotificationJob < ActiveJob::Base
  queue_as :notifications

  def perform(name, url, email)
    
    bot = Xmpp4rHangouts.new(
      email:    Settings.action_mailer.email, 
      password: Settings.action_mailer.password
    )
    
    bot.get_online
    bot.message(email, "New episode of #{name} series is released.")
    bot.message(email, "Go to this link to watch it: #{url}")
  end
end
