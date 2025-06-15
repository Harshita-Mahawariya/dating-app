# lib/omniauth/instagram.rb

require 'httparty'

module Omniauth
  class Instagram
    include HTTParty

    # The base uri for facebook graph API
    base_uri 'https://graph.instagram.com/v2.3'

    def get_user_profile(access_token)
      options = { query: { access_token: access_token } }
      response = self.class.get('/me', options)
      response.parsed_response
    end
  end
end