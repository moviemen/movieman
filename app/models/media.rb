class Media
  include Mongoid::Document

  field :type, type: String
  field :name, type: String

  has_many :sources
  has_many :synonims
end
