require './lib/omniauth/instagram.rb'

# BxBlockLogin::FacebookDetailsApi.call(access_token)
module BxBlockLogin
  module InstagramDetailsApi
    class << self
      def call(access_token)
        res = Omniauth::Instagram.new.get_user_profile(access_token)

        if res['error']
          Rails.logger.error res
          {success: false, error: res['error']['message']}
        else
          url = get_url(res['id'], access_token)
          response = HTTParty.get(url)

          {success: true, email: response['email'], response: response}
        end
      end

      private
      def get_url(response_id, access_token)
        "https://graph.instagram.com/#{response_id}?fields=email&access_token=#{access_token}"
      end
    end
  end
end
