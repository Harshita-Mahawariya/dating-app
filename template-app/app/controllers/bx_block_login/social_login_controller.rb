# Social media login
module BxBlockLogin
  class SocialLoginController < ApplicationController
    def create
      response = get_response(params[:data][:type], params[:data][:attributes])

      if response[:success]
        account = AccountBlock::Account.find_by(email: response[:email], activated: true)
        is_new_user = true
        if account.present?
          token = BuilderJsonWebToken.encode(account.id)
          is_new_user = false
        end

        render json: AccountBlock::AccountSerializer.new(account, meta: {
          is_new_user: is_new_user,
          email: response[:email],
          token: token,
        }).serializable_hash, status: 200
      else
        render json: {
          errors: [{
            error: response[:error],
          }]
        }, status: :unprocessable_entity
      end
    end

    private
    def get_response(type, attributes)
      case type
      when 'google'
        BxBlockLogin::GoogleDetailsApi.call(attributes[:access_token])
      when 'facebook'
        BxBlockLogin::FacebookDetailsApi.call(attributes[:access_token])
      when 'instagram'
        BxBlockLogin::InstagramDetailsApi.call(attributes[:access_token])
      else
        {success: false, error: "Invalid Login Type: #{type}"}
      end
    end
  end
end
