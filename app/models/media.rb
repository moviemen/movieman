class Media
  include Mongoid::Document
  include Mongoid::Timestamps

  field :type,    type: String
  field :name,    type: String
  field :picture, type: String

  has_many   :sources
  has_many   :synonyms
  belongs_to :subscribe

  scope :movies,    -> { where(type: 'movie')     }
  scope :tv_series, -> { where(type: 'tv_series') }
end
