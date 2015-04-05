class VkontakteService

  def self.notify episode_id
    # here will be vk messages
    users = Episode.find(episode_id).users.pluck(:email)
    puts "Vkontakte Notification was sent to #{users.to_s}"
  end

end