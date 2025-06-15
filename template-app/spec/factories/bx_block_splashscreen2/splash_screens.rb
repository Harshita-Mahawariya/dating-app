FactoryBot.define do
  factory :splash_screen, class: 'BxBlockSplashscreen2::SplashScreen' do
    after(:build) do |splash_screen|
      splash_screen.video.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'demo.mp4')),
        filename: 'demo.mp4',
        content_type: 'video/mp4'
      )
    end
  end
end
