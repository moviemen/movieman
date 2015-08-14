class Identity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of   :uid, :provider, :oauth_token#, :oauth_expires_at
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_for_oauth(auth)
    identity = where(uid: auth.uid, provider: auth.provider).first

    unless identity
      identity = Identity.new(uid: auth.uid, provider: auth.provider)    
    end
    
    identity[:oauth_token]      = auth.credentials.token
    identity[:oauth_expires_at] = Time.at(auth.credentials.expires_at) if auth.credentials.expires_at
    
    identity.save! 

    identity
  end
end