class FacebookNotificationJob < ActiveJob::Base
  queue_as :notifications

  def perform(name, photo, url, token)
    user = FbGraph::User.me(token).fetch
    app  = FbGraph::Application.new('418149471697025', :secret => 'f26ec67380b93f71e28dd6cc56f208d8')
    app.notify!(user, :href => '#asds', :template => "New episode of is released")    
  end
end
