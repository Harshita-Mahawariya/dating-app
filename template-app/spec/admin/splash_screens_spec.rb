require 'rails_helper'
require 'spec_helper'
include Warden::Test::Helpers
RSpec.describe Admin::SplashScreensController, type: :controller do
  render_views
  before(:each) do
    @admin = AdminUser.create!(email: 'test123@example.com', password: 'password', password_confirmation: 'password')
    @admin.save
    @splash = FactoryBot.create(:splash_screen)
    sign_in @admin
  end

  describe 'SplasScreen#new' do
    let(:params) do {
      video: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'demo.mp4'), 'video/mp4')
    }
    end
    it 'create splash screen' do
      post :new, params: params
      expect(response).to have_http_status(200)
    end
  end

  describe 'Get#index' do
    it 'show all the splash screen' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe 'Get#show' do
    it "show splash screen" do
      get :show, params: {id: @splash.id}
      expect(response).to have_http_status(200)
    end
  end
end