class Subscribe
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id,  type: Integer

  belongs_to :user
  has_one    :media

end
