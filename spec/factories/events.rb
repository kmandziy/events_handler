# frozen_string_literal: true

# spec/factories/users.rb
FactoryBot.define do
  factory :event do
    name { 'John Doe' }
    email { Faker::Internet.email }
    password { 'password' }
  end
end
