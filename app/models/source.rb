class Source
  include Mongoid::Document
  include Mongoid::Timestamps

  field :link,     type: String
  field :media_id, type: Integer
  field :season,   type: Integer, default: nil
  field :episode,  type: Integer, default: nil

  belongs_to :media

  after_update :notify_subscribers, if: :released?

  protected

  def released?
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
