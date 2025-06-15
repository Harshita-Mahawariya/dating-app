require 'rails_helper'

RSpec.describe BxBlockContactUs::ContactsController, type: :request do
  let(:contact_params) { 
    {
      "data": {
          "name":"juned",
          "email": "juned1@gmail.com",
          "phone_number":918765439078,
          "description": "hello"
      }
  }
}

  describe "POST /bx_block_contact_us/contacts" do
    before do
      account = AccountBlock::Account.find_by(email: "test@gmail.com")
      unless
        account = AccountBlock::Account.create(full_name: "test", email: "test@gmail.com", password: "Rails@1234", password_confirmation: "Rails@1234", activated: true, full_phone_number: 911234567890)
      end
      @token = BuilderJsonWebToken.encode(account.id)
    end

    it "should create new contact" do
      post '/bx_block_contact_us/contacts', params: contact_params, headers: {token: @token}
      expect(response).to have_http_status(201)
    end
  end
end
