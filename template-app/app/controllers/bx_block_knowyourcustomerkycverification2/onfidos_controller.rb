module BxBlockKnowyourcustomerkycverification2
  class OnfidosController < ApplicationController
    before_action :validate_json_web_token, :current_user, except: [:webhook_response, :applicant_create, :retrieve_onfido_report]
    before_action :onfido_api

    def webhook_response
      begin
        message = "Webhook In Progress"
        if params[:payload][:resource_type] == "report"
          report_id = params[:payload][:object][:id]
          if report_id.present?
            report_data = @onfido.report.find(report_id)
            check = @onfido.check.find(report_data["check_id"])
            check_id = check['id']
            kyc_user = BxBlockKnowyourcustomerkycverification2::Onfido.find_by(onfido_applicant_id: check['applicant_id'])
            result = kyc_user.present? && report_data["result"] == "clear"
          end
        elsif params[:payload][:resource_type] == "check"
          check_id = params[:payload][:object][:id]
          applicant_id = @onfido.check.find(check_id)["applicant_id"]
          kyc_user = BxBlockKnowyourcustomerkycverification2::Onfido.find_by(onfido_applicant_id: applicant_id)
          result = kyc_user.present? && @onfido.check.find(check_id)["result"] == "clear"
        end
        kyc_user.submitted! if result == false
        if kyc_user.present? && result
          kyc_user.update(kyc_status: BxBlockKnowyourcustomerkycverification2::Onfido.kyc_statuses['verified'], onfido_check_id: check_id)
          message = "KYC Approved"
        end
        return render json: { message: message }, status: 200
      rescue StandardError => e
        return render json: { message: 'Something went wrong' }, status: :unprocessable_entity
      end
    end

    def retrieve_onfido_report
      return render json: { message: 'Applicant is required' }, status: :unprocessable_entity unless params['applicant_id'].present?

      applicant = BxBlockKnowyourcustomerkycverification2::Onfido.find_by(onfido_applicant_id: params['applicant_id'])
      return render json: { message: 'Applicant not exist' }, status: :unprocessable_entity unless applicant.present?
      check = find_check(applicant.onfido_applicant_id)

      if check['checks'].blank?
        render json: applicant
      else
        kyc_status = check['checks'].map { |c| c['result'] }.uniq.first == 'clear' ? 2 : 1
        applicant.update(onfido_check_id: check['checks'].first['id'], kyc_status: kyc_status)

        reports = find_report(applicant.onfido_check_id)
        applicant.update(
          onfido_report_id: reports['reports'].map { |r| r['id'] },
          document_type: reports['reports'].map { |r| r['name'] },
          reports_status: reports['reports'].map { |r| r['result'] == 'clear' ? 'approved' : 'submitted' }
        )
        render json: applicant
      end
    end

    def applicant_create
      onfido_account_details = {
        first_name: onfido_params[:first_name],
        last_name:  onfido_params[:last_name],
        middle_name: onfido_params[:middle_name],
        email: onfido_params[:email],
        dob: onfido_params[:date_of_birth],
        phone_number: onfido_params[:phone_number],
        location: {
          country_of_residence: onfido_params[:nationality]
        },
        consents: [
          {
            name: "privacy_notices_read",
            granted: true
          }
        ]
      }

      if onfido_account_details.values.all?(&:present?)
        applicant = BxBlockKnowyourcustomerkycverification2::Onfido.find_by(email: onfido_params[:email])
        if applicant.present?
          render json: { message: 'Applicant is already exists' }
        else
          applicant = @onfido.applicant.create(onfido_account_details)
          BxBlockKnowyourcustomerkycverification2::Onfido.create(onfido_applicant_id: applicant['id'], email: applicant['email'], kyc_status: 0)
          render json: applicant
        end
      else
        render json: { errors: [{ message: 'All values should be entered' }] }, status: :unprocessable_entity
      end
    rescue StandardError => e
      render json: { message: e }, status: :unprocessable_entity
    end

    private
    def onfido_api
      @onfido = BxBlockOnfido::OnfidoOperations.new.call
    end

    def find_check(applicant_id)
      @onfido.check.all(applicant_id)
    end

    def find_report(check_id)
      @onfido.report.all(check_id)
    end

    def onfido_params
      params.require(:data).permit(:first_name, :last_name, :middle_name, :email, :phone_number, :nationality, :gender, :date_of_birth)
    end
  end
end
