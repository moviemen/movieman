class Episode < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :name,         presence: true
  validates :url,          presence: true
  validates :last_season,  presence: true 
  validates :last_episode, presence: true 
  validates :photo,        presence: true 

  after_save :email_on_updates

  self.per_page = 25

  private

  def email_on_updates
    #EmailService.notify self
    #FacebookService.notify self
    #HangoutsService.notify self
    #SmsService.notify self
    #TwitterService.notify self
    #VkontakteService.notify self
  end

end
