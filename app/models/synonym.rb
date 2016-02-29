class Synonym
  include Mongoid::Document

  field :name,     type: String
  field :media_id, type: Integer

  belongs_to :media
end
