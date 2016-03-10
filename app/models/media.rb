class Media
  include Mongoid::Document
  include Mongoid::Timestamps

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  field :kind,    type: String
  field :names,   type: Array
  field :link,    type: String
  field :picture, type: String

  validates :link, presence: true
  validates :name, uniqueness: {scope: :name} 

  has_and_belongs_to_many :users, index: true

  default_scope -> { asc(:name) }

  scope :movies,    -> { where(kind: 'movies')    }
  scope :tv_series, -> { where(kind: 'tv_series') }

  def name
    names.first
  end

  def name=(value)
    names << value
  end

  def movie?
    kind.eql? 'movies'
  end

  def tv_series?
    kind.eql? 'tv_series'
  end

  def picture_path
    "#{kind}/#{picture}"
  end

  index({ kind: 1 }, { background: true })
  index({ name: 1, kind: 1 }, { background: true, unique: true })
end
