class NewEpisodeJob < ActiveJob::Base
  queue_as :email

  def perform(user_id, media, episode)
    NotificationMailer.new_episode_email(user_id, media, episode).deliver_now
  end
end