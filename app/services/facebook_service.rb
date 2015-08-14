class FacebookService
  
  def self.notify episode
    episode.users.each do |user|

      user.identities.where(provider: 'facebook').each do |identity|
        job = FacebookNotificationJob.new(episode.name, episode.photo, episode.url, identity.oauth_token)
        job.enqueue(wait: 10.seconds)
      end
    
    end
  end

end 

#    user = FbGraph::User.fetch('bohdan.malets')
#    app = FbGraph::Application.new('418149471697025', :secret => 'f26ec67380b93f71e28dd6cc56f208d8')
#    app.notify!(user,:href => '#',:template => 'test test <a href="http://localhost:3000">asdasdas</a> test opa test')
