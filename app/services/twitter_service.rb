class TwitterService

  def self.notify episode_id
    # here will be twitter messages
    users = Episode.find(episode_id).users.pluck(:email)
    puts "Twitter Notification was sent to #{users.to_s}"
  end

end