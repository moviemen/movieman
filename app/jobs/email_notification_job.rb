class EmailNotificationJob < ActiveJob::Base
  queue_as :notifications

  def perform(episode_id, email)
    NotificationMailer.new_episode_added(episode_id, email).deliver_now
  end
end
