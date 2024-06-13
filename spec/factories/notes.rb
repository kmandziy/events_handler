# frozen_string_literal: true

FactoryBot.define do
  factory :note do
    content { Faker::Lorem.sentences(number: 3).join("\n") }
    application
  end
end
