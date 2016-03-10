class Media::TvSeries < Media
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :season,   type: Integer
  field :episode,  type: Integer

  after_update :notify_subscribers, if: :is_released?

  default_scope -> { where(kind: 'tv_series') }

  protected

  def is_released?
    self.season_changed? or self.episode_changed?
  end

  def notify_subscribers
    self.subscribes.pluck(:user_id).each do |user_id|
      job = if premiere?
        NewReleaseJob.new(user_id.to_s, self.name)
      elsif new_episode_released?
        NewEpisodeJob.new(user_id.to_s, self.name, self.episode)
      elsif new_season_released?
        NewSeasonJob.new(user_id.to_s, self.season, self.name)
      end
      job.enqueue
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