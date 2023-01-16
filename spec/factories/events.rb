# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    title { Faker::Lorem.word }
    content { Faker::Lorem.paragraph_by_chars(number: 100) }
    held_at { Time.current + 1.month }
    prefecture_id { [*1..47].sample }
    only_women { :unspecified }
    association :user
  end
end
