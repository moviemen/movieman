class Media
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :type,         type: String
  field :name,         type: String
  field :picture,      type: String

  embeds_many :sources
  embeds_many :synonyms

  has_and_belongs_to_many :users

  default_scope -> { asc(:name) }

  scope :movies,    -> { where(type: 'movies')    }
  scope :tv_series, -> { where(type: 'tv_series') }

  def movie?
    type.eql? 'movies'
  end

  def picture_path
    "#{type}/#{picture}"
  end
end
