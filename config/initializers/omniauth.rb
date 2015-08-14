Devise.setup do |config|

  # config.omniauth :github, 'APP_ID', 'APP_SECRET', scope: 'user,public_repo'
  config.omniauth :facebook, 
                  "418149471697025", 
                  "f26ec67380b93f71e28dd6cc56f208d8", 
                  :scope => 'public_profile,email,publish_actions'

  config.omniauth :twitter,
                  "g2j8CoWLmS0DIlDwxUmNo3K5z",         
                  "PT0WZLEPwveD1SPc98lM8Ro2wqyewCOUwkzl3xVXzSPiSeCd1l"
  
  config.omniauth :vkontakte, 
                  "4885480",         
                  "9H8HsMs4IQHBYmsAWEOF"#,
                  #:scope => 'messages,notify'

  config.omniauth :google_oauth2, 
                  "877915859386-159389tmh52jmc46f0ek0tja0aamdel5.apps.googleusercontent.com", 
                  "WOZ6MXgnqHsU18pD4x64Jp9L", 
                  { 
                    access_type: "offline", 
                    approval_prompt: "force", 
                    scope: "userinfo.email" 
                  }
end

module OmniAuth
  module Strategy
    def full_host
      uri = URI.parse(request.url)
      uri.path = ''
      uri.query = nil
      uri.port = (uri.scheme == 'https' ? 443 : 80)
      uri.to_s
    end
  end
end