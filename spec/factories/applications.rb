# frozen_string_literal: true

FactoryBot.define do
  factory :application do
    candidate_name { Faker::Name.name }
    status { :applied }
    job

    trait :interview do
      status { :interview }
    end

    trait :hired do
      status { :hired }
    end

    trait :rejected do
      status { :rejected }
    end

    trait :with_note do
      status { :rejected }
    end
  end
end
