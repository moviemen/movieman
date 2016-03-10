class Media::Movie
  include Mongoid::Document

  field :released, type: Boolean

  default_scope -> { where(kind: 'movies') }
end