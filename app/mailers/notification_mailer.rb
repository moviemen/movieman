class NotificationMailer < ActionMailer::Base
  default from: 'movieman@example.com' #temporary

  def new_episode_email(user_id, media, episode)
    user = User.find(user_id)
    mail(
        to:      user.email,
        subject: "New episode of #{media} just came out!",
        #temporary body
        body:    "We are glad to inform you new episode #{episode} of #{media} came out."
    )
  end

  def new_season_email(user_id, season, media)
    user = User.find(user_id)
    mail(
        to:      user.email,
        subject: "New season of #{media} just came out!",
        #temporary body
        body:    "We are glad to inform you new season #{season} of #{media} came out."
    )
  end

  def new_release_email(user_id, media)
    user = User.find(user_id)
    mail(
        to:      user.email,
        subject: "New season of #{media} just came out!",
        #temporary body
        body:    "We are excited to inform you about brand new TV-series #{media} just came out."
    )
  end
end