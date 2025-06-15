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
                "access_token": "ya29.a0AVvZVsqpSSohJ5-b2TgF8Ny6wDvyFd9j-nFP3WWEksA6LKHVdCWUkC4MCTzRUy91h8l3wR4w46VYl09YRppg87QYdnyR7avf-q2-D0J3cAoaG4bpiyEXWsKRJz1oDMVUiLJVxfr_e0XWMhdnyYUBaQ1vgZfUaCgYKAaYSARASFQGbdwaI7Bou5blTkE3IQlppJpwCzA0163"
            }
    
        }
    }
  }

  let (:facebook_param) { 
    {
      "data": {
          "type": "facebook",
          "attributes":{
              "access_token": "EAAMotySj39oBAJt7QXb5xbVXtHV8RvZBYZAgHxlFv2jpTXC4V4H4AEpZAlY6xZCQcwiQZC0MQaj6GtZAwd7XiUZB44cpNgy5ToXl3ixusMZCcROxNOAuBrZBtZBgvjhPzE5tyuBdo0VV8G8F1sAAByS6PlfH1dJ0SB8H0SWwkRSeSGyQuZA9Ja1S599"
          }
  
      }
  }
}

# let (:insta_param) { 
#   {
#     "data": {
#         "type": "instagram",
#         "attributes":{
#             "access_token": "IGQVJYWXJQMzRNRS1qdXhXZAC0yWGZAzbGhOaWZA1dVlEQzJkTFNmbkpzRERfNkpfbWtobk0yNHVCWlUwTnFfOFM1VFhxTVIyVmlCMWhhUkdVZATh1UU5raDA4Rnk3dERINFNJOWNESlB1U0t4UnpRcXpZAbgZDZD"
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
