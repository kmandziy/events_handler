# frozen_string_literal: true

FactoryBot.define do
  factory :interview do
    interview_date { Faker::Time.between(from: DateTime.now, to: DateTime.now + 10.days) }
    application
  end
end
