class NotificationMailer < ApplicationMailer
  default from: Settings.action_mailer.email

  def new_episode_added episode_id, user_email
    @episode = Episode.find episode_id
    mail(to: user_email, subject: 'MovieMan Notification')
  end

end
