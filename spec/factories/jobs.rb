# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    title { Faker::Job.title }
    description { Faker::Lorem.sentences(number: 3).join("\n") }
    status { :deactivated }

    trait :activated do
      status { :activated }
    end
  end
end
