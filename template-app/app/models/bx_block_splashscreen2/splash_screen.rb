module BxBlockSplashscreen2
  class SplashScreen < BxBlockSplashscreen2::ApplicationRecord
    self.table_name = :splash_screens
    has_one_attached :video
    validates :video, presence: true
    validate :create_only_one, on: :create

    private

    def create_only_one
      errors.add(:base, "There can only be one Splash Screen") if SplashScreen.count > 0
    end
  end
end
