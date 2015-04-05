class Episode < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :name,         presence: true
  validates :url,          presence: true
  validates :last_season,  presence: true 
  validates :last_episode, presence: true 
  validates :photo,        presence: true 
end
