class Subscribe
  include Mongoid::Document
  field :media_id, type: Integer
  field :user_id, type: Integer

  belongs_to :user
  has_one :media
end
