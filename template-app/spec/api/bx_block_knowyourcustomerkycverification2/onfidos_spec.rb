require 'rails_helper'
require 'vcr'

RSpec.describe BxBlockKnowyourcustomerkycverification2::OnfidosController, type: :controller do

  describe "#create_applicant" do
    let(:data) do
      {
        first_name: "Jane",
        last_name: "Doe",
        middle_name: "Smith",
        date_of_birth: "1990-01-31",
        email: "test@example.com",
        phone_number: '9121212323',
        nationality: 'GBR'
      }
    end

    it 'creates a new applicant without login' do
      VCR.use_cassette('onfido_create_applicant_without_login') do
        post :applicant_create, params: { data: data }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('id')
      end
    end

    it 'errorn on creates applicant without login' do
      VCR.use_cassette('error_onfido_create_applicant_without_login') do
        data.delete(:email)
        post :applicant_create, params: { data: data }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    it 'errorn on wrong email' do
      VCR.use_cassette('onfido_return_error') do
        data[:email] = "abc"
        post :applicant_create, params: { data: data }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    it 'applicant is all ready exist' do
      applicant = FactoryBot.create(:onfido_pending, email: 'test@example.com')
      post :applicant_create, params: { data: data }
      expect(response.body).to include('Applicant is already exists')
    end
  end

  describe "#webhook_response" do
    it "webhook response with report" do
      VCR.use_cassette('webhook_response') do
        applicant = FactoryBot.create(:onfido)
        post :webhook_response, params: {payload: {resource_type: "report", object: {id: '21d951ae-1fa6-42a2-9604-07c3e10f0683', type: "driving_licence"}}}
        expect(response).to have_http_status(:ok)
        expect(applicant.onfido_applicant_id).to_not be_nil
        expect(applicant.reload.onfido_check_id).to_not be_nil
        expect(applicant.kyc_status).to_not be_nil
        expect(applicant.reload.kyc_status).to eq('verified')
      end
    end

    it "webhook response with check" do
      VCR.use_cassette('webhook_response_with_check_id') do
        applicant = FactoryBot.create(:onfido)
        post :webhook_response, params: {payload: {resource_type: "check", object: {id: '2533949e-0519-4799-8887-2a3cd22421bd'}}}
        expect(applicant.onfido_applicant_id).to_not be_nil
        expect(applicant.reload.onfido_check_id).to_not be_nil
        expect(applicant.kyc_status).to_not be_nil
        expect(applicant.reload.kyc_status).to eq('verified')
      end
    end

    it "webhook response with check" do
      VCR.use_cassette('webhook_response_with_check_id') do
        applicant = FactoryBot.create(:onfido)
        post :webhook_response, params: {payload: {resource_type: "check", object: {id: '2533949e-0519-4799-8887-2a3cd421bd'}}}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Something went wrong')
      end
    end

    it "retrieve onfido" do
      VCR.use_cassette('retrieve_onfido_report') do
        onfido = FactoryBot.create(:onfido_report)
        get :retrieve_onfido_report, params: { applicant_id: onfido.onfido_applicant_id}
        expect(onfido.onfido_applicant_id).to_not be_nil
        expect(onfido.reload.onfido_check_id).to_not be_nil
        expect(onfido.kyc_status).to_not be_nil
        expect(onfido.reload.kyc_status).to eq('verified')
      end
     end

     it "return error on retrieve onfido" do
      get :retrieve_onfido_report, params: { applicant_id: ''}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include('Applicant is required')
    end

    it "check is blank retrieve onfido" do
      VCR.use_cassette('error_on_retrieve_report') do
        onfido = FactoryBot.create(:onfido_pending)
        get :retrieve_onfido_report, params: { applicant_id: onfido.onfido_applicant_id}
        expect(onfido.onfido_applicant_id).to_not be_nil
        expect(onfido.reload.onfido_check_id).to be_nil
        expect(onfido.kyc_status).to_not be_nil
        expect(onfido.reload.kyc_status).to eq('pending')
      end
    end
  end
end
