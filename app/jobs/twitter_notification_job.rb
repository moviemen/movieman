class TwitterNotificationJob < ActiveJob::Base
  queue_as :notifications

  def perform(name, photo, url, uid, client)   
    client.create_direct_message(uid, "New episode of is released")
  end
end
