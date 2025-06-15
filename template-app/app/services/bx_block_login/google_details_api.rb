# BxBlockLogin::GoogleDetailsApi.call(access_token)
require "uri"
require "net/http"
module BxBlockLogin
  module GoogleDetailsApi
    # GOOGLE_URL = "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token="


    class << self
      def call(access_token)
        url = URI("https://www.googleapis.com/oauth2/v2/userinfo")

        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true
        
        request = Net::HTTP::Get.new(url)
        request["Authorization"] = "Bearer "+ access_token
        
        response = JSON.parse(https.request(request).read_body)
        
        if response["error_description"]
          Rails.logger.error response
          {success: false, error: response["error_description"]}
        else
          {success: true, email: response['email'], response: response}
        end
      end
    end
  end
end
