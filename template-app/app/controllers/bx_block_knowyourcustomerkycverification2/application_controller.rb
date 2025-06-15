module BxBlockKnowyourcustomerkycverification2
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation

    before_action :validate_json_web_token, :current_user, :onfido_api
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    private

    def not_found
      render :json => {'errors' => ['Record not found']}, :status => :not_found
    end

    def current_user
      @current_user = AccountBlock::Account.find(@token.id)
    rescue ActiveRecord::RecordNotFound => e
      render json: {errors: [
        {message: "Please login again."}
      ]}, status: :unprocessable_entity
    end

    def onfido_api
      @onfido = BxBlockOnfido::OnfidoOperations.new.call
    end
  end
end
