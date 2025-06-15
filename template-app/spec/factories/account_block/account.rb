# frozen_string_literal: true

FactoryBot.define do
  factory :account, class: AccountBlock::Account do
    first_name { Faker::Name.unique.first_name }
    last_name { Faker::Name.unique.last_name }
    email { Faker::Internet.unique.email }
    password_digest { 'test@123' }
    activated { true }
  end
end
