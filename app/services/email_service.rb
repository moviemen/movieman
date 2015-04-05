class EmailService

  def self.notify episode_id
    Episode.find(episode_id).users.pluck(:email).each do |email| 
      NotificationMailer.new_episode_added(episode_id, email).deliver
    end
  end

end