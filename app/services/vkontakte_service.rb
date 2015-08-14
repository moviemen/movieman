require 'open-uri'

class VkontakteService

  def self.notify episode
    # here will be vk messages
    user = Identity.first
    
    params = "user_id=#{user.uid}&message=notification+text";
    token = "access_token=#{user.oauth_token}";
    method = "messages.send";
    request = "https://api.vk.com/method/"+ method +"?"+ params +"&"+ token;

    response = open(request).read
  end

end