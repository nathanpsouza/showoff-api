# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.last_name }
    last_name { Faker::Name.last_name }
    password { '123123123' }
  end
end
