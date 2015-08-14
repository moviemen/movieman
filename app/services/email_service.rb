class EmailService

  def self.notify episode
    episode.users.pluck(:email).each do |email| 
      EmailNotificationJob.new(episode.id, email).enqueue(wait: 10.seconds)
    end
  end

end