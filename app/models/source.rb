class Source
  include Mongoid::Document
  include Mongoid::Timestamps

  field :link,     type: String
  field :media_id, type: Integer
  field :season,   type: Integer, default: 0
  field :episode,  type: Integer, default: 0

  belongs_to :media

  before_update :notify_subscribers, if: :episode_released?

  protected

  def episode_released?
    self.season_changed? or self.episode_changed?
  end

  def notify_subscribers
    self.media.subscribes.pluck(:user_id).each do |user_id|
      SomeEmailJob.notify user_id.to_s
    end
  end

end
