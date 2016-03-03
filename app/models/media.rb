class Media
  include Mongoid::Document
  include Mongoid::Timestamps

  field :type,         type: String
  field :name,         type: String
  field :picture,      type: String


  has_many :sources
  has_many :synonyms
  has_many :subscriptions

  default_scope -> { asc(:name) }

  scope :movies, -> { where(type: 'movies')     }
  scope :tv_series, -> { where(type: 'tv_series') }
end
