class HangoutsService

  def self.notify episode
    episode.users.pluck(:email).each do |email| 
      HangoutsNotificationJob.new(episode.name, episode.url, email).enqueue(wait: 10.seconds)
    end
  end

end