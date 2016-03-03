class Media
  include Mongoid::Document
  include Mongoid::Timestamps

  field :type,         type: String
  field :name,         type: String
  field :picture,      type: String
  field :released,     type: Boolean, default: false

  has_many :sources
  has_many :synonyms
  has_many :subscriptions

  default_scope -> { asc(:name) }

  scope :movies,    -> { where(type: 'movie')     }
  scope :tv_series, -> { where(type: 'tv_series') }
end
