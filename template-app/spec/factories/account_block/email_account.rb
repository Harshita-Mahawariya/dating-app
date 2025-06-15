# frozen_string_literal: true

FactoryBot.define do
  factory :email_account, class: AccountBlock::EmailAccount do
    first_name { Faker::Name.unique.name }
    last_name { Faker::Name.unique.name }
    email { Faker::Internet.email }
    password { 'test@123' }
    onfido_applicant_id { "42e98f6c-f8c8-4cae-a243-199b8e65e835" }
    activated { true }
    type { 'EmailAccount' }
    full_phone_number { "91#{Faker::Number.number(digits: 10)}" }
  end
end
