class Source
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :link,     type: String
  field :media_id, type: Integer
  field :season,   type: Integer
  field :episode,  type: Integer
  field :released, type: Boolean

  embedded_in :media

  after_update :notify_subscribers, if: :is_released?

  validates_presence_of :link

  protected

  def is_released?
    self.season_changed? or self.episode_changed?
  end

  def notify_subscribers
    self.media.subscribes.pluck(:user_id).each do |user_id|
      if premiere?
        NewReleaseJob.new(user_id.to_s, self.media.name).enqueue
      elsif new_episode_released?
        NewEpisodeJob.new(user_id.to_s, self.media.name, self.episode).enqueue
      elsif new_season_released?
        NewSeasonJob.new(user_id.to_s, self.season, self.media.name).enqueue
      end
    end
  end

  def premiere?
    self.season_change.first.nil? if season_changed?
  end

  def new_season_released?
    self.season_changed? and self.episode_changed?
  end

  def new_episode_released?
    !self.season_changed? and self.episode_changed?
  end

end
