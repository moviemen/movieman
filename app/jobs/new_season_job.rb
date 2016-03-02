class NewSeasonJob < ActiveJob::Base
  queue_as :email

  def perform(user_id, season, media)
    NotificationMailer.new_season_email(user_id, season, media).deliver_now
  end
end