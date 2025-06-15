FactoryBot.define do
  factory :onfido, class: BxBlockKnowyourcustomerkycverification2::Onfido do
    onfido_applicant_id { 'f1affaa2-61e4-4be7-bc1f-da0487f67876' }
    email { Faker::Internet.unique.email }
  end

  factory :onfido_pending, class: BxBlockKnowyourcustomerkycverification2::Onfido do
    onfido_applicant_id { '71014405-9df6-4a6e-a14b-f0066235f010' }
    email { 'Faker::Internet.unique.email' }
  end

  factory :onfido_report, class: BxBlockKnowyourcustomerkycverification2::Onfido do
    onfido_applicant_id { 'f1affaa2-61e4-4be7-bc1f-da0487f67876' }
    onfido_check_id { '2533949e-0519-4799-8887-2a3cd22421bd' }
    email { Faker::Internet.unique.email }
    kyc_status { 'verified' }
  end
end
