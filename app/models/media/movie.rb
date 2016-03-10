class Media::Movie < Media
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :released, type: Boolean

  default_scope -> { where(kind: 'movies') }
end