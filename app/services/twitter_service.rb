class TwitterService

  def self.notify episode
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "g2j8CoWLmS0DIlDwxUmNo3K5z"
      config.consumer_secret     = "PT0WZLEPwveD1SPc98lM8Ro2wqyewCOUwkzl3xVXzSPiSeCd1l"
      config.access_token        = "3188227797-u4gpvKi9WO10pzZYYpmogdTCJonptroh65zK4ZU"
      config.access_token_secret = "BGgQpfdis5K7Bp9VoUQlX1CMp0Ms4TMRRG0vFccMOhEHf"
    end

    episode.users.each do |user|

      user.identities.where(provider: 'twitter').each do |identity|
        job = TwitterNotificationJob.new(episode.name, episode.photo, episode.url, identity.uid, client)
        job.enqueue(wait: 10.seconds)
      end
    
    end
  end

end