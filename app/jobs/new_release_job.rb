class NewReleaseJob < ActiveJob::Base
  queue_as :email

  def perform(user_id, media)
    NotificationMailer.new_release_email(user_id, media).deliver_now
  end
end