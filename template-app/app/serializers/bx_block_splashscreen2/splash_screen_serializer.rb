module BxBlockSplashscreen2
  class SplashScreenSerializer < BuilderBase::BaseSerializer
    attributes :video do |object|
      if object&.video.attached?
        Rails.application.routes.url_helpers.rails_blob_url(object.video, only_path: true)
      end
    end
  end
end