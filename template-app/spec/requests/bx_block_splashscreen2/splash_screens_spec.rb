require 'rails_helper'

RSpec.describe 'BxBlockSplashscreen2::SplashScreens', type: :request do
  describe 'GET /bx_block_splashscreen2/splash_screens' do
    it 'is expected get SplashScreen' do
      splash = FactoryBot.create(:splash_screen)
      get "/bx_block_splashscreen2/splash_screens/#{splash.id}"
      expect(response).to have_http_status(200)
    end

    it 'is expected to get error Record not found' do
      get '/bx_block_splashscreen2/splash_screens/1'
      message = JSON.parse(response.body)['message']
      expect(message).to include('Record not found')
    end
  end
end
