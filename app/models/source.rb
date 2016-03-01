class Source
  include Mongoid::Document
  include Mongoid::Timestamps

  after_update :send_notification_after_change

  field :link,     type: String
  field :media_id, type: Integer
  field :season,   type: Integer, default: 0
  field :episode,  type: Integer, default: 0

  belongs_to :media

  private

  def send_notification_after_change
    s = season_changed?
    binding.pry

    

    # if season_changed? || episode_changed?

    # user = media.subscribe.user
    # mail(to: user.email, subject: 'Movie/TV Series update')
  end

end
