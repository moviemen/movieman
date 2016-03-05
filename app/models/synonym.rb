class Synonym
  include Mongoid::Document

  field :name,     type: String
  field :media_id, type: Integer

  embedded_in :media
end
