class SmsService

  def self.notify episode_id
    # here will be sms messages
    users = Episode.find(episode_id).users.pluck(:email)
    puts "SMS Notification was sent to #{users.to_s}"
  end

end