class NotificationMailer < ApplicationMailer
  default from: Settings.action_mailer.email

  def new_episode_added episode_id, user_email
    @episode = Episode.find episode_id
    mail(to: user_email, subject: "MovieMan: #{@episode.name} new episode.")
  end

  def start_checking
    mail(to: 'b.malets@gmail.com', subject: 'MovieMan: Parsing start')
  end

  def finish_checking
    mail(to: 'b.malets@gmail.com', subject: 'MovieMan: Parsing end')
  end

  def error_checking
    mail(to: 'b.malets@gmail.com', subject: 'MovieMan: finished with errors.')
  end

end
