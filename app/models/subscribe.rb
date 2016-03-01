class Subscribe
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id,  type: Integer
  field :media_id, type: Integer

  belongs_to :users
  belongs_to :media
end
