class FacebookService
  
  def self.notify episode_id
    # here will be facebook messages
    users = Episode.find(episode_id).users.pluck(:email)
    puts "Facebook Notification was sent to #{users.to_s}"
  end

end