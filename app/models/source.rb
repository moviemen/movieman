class Source
  include Mongoid::Document

  field :link,     type: String
  field :media_id, type: Integer
  field :season,   type: Integer
  field :eposode,  type: Integer

  belongs_to :media
end
