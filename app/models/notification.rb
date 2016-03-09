class Notification
  include Mongoid::Document

  field :mail,     type: Boolean, default: false
  field :facebook,  type: Boolean, default: false
  field :vkontakte, type: Boolean, default: false
  field :twitter,   type: Boolean, default: false

  embedded_in :user
end
