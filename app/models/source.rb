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
      # SomeEmailJob.notify user_id.to_s
      if premiere?
        SomeEmailJob.notify_about_release(user_id, self.media)
      elsif new_episode_released?
        SomeEmailJob.notify_about_new_episode(user_id, self.media)
      elsif season_released?
        SomeEmailJob.notify_about_new_season(user_id, self.media)
      end
    end
  end

  def premiere?
    self.season_change.first.nil?
  end

  def season_released?
    self.season_changed? and self.episode_changed?
  end

  def new_episode_released?
    !self.season_changed? and self.episode_changed?
  end

end
