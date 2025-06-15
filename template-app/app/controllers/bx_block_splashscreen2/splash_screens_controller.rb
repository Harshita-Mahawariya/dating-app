module BxBlockSplashscreen2
  class SplashScreensController < BxBlockSplashscreen2::ApplicationController
    skip_before_action :validate_json_web_token, only: %i[show], raise: false

    def show
      unless BxBlockSplashscreen2::SplashScreen.exists?
        return render json: { message: 'Record not found'}, status: :not_found
      end

      serializer = SplashScreenSerializer.new(SplashScreen.first)
      render json: serializer.serializable_hash,
             status: :ok
    end
  end
end
