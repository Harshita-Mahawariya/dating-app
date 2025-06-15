require 'rails_helper'

RSpec.describe BxBlockLogin::SocialLoginController, type: :request do
  before do
    @url =  "/bx_block_login/social_login"
  end
  let (:google_param) { 
      {
        "data": {
            "type": "google",
            "attributes":{
                "access_token": ""
            }
    
        }
    }
  }

  let (:facebook_param) { 
    {
      "data": {
          "type": "facebook",
          "attributes":{
              "access_token": ""
          }
  
      }
  }
}

# let (:insta_param) { 
#   {
#     "data": {
#         "type": "instagram",
#         "attributes":{
#             "access_token": ""
#         }

#     }
# }
# }





  
let (:error_param) {
  {
    "data": {
        "type": "twitter",
        "attributes":{
            "access_token": "sdsfsjhdj"
        }

    }
}
}
  describe "social login" do
    it "should login with google" do
      post @url, params: google_param
      expect(response).to have_http_status 200
    end

    it "should login with facebook" do
      post @url, params: facebook_param
      expect(response).to have_http_status 200
    end

    # it "should login with instagram" do
    #   post @url, params: insta_param
    #   expect(response).to have_http_status 200
    # end

    it "should be invalid login" do
      post @url, params: error_param
      expect(response).to have_http_status 422
    end
  end
end
