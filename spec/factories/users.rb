# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { 'password' }
    password_confirmation { 'password' }
    gender { :LGTM }

    trait :LGBT do
      gender { :LGBT }
    end

    trait :man do
      gender { :man }
    end

    trait :woman do
      gender { :woman }
    end

    trait :another_woman do
      gender { :woman }
    end
  end
end
