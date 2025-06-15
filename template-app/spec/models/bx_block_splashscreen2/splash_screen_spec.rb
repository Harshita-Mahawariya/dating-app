require 'rails_helper'

RSpec.describe BxBlockSplashscreen2::SplashScreen, type: :model do

  describe 'active_storage' do
    it { should have_one_attached(:video) }
  end
end
