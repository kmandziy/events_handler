# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    trait :application_interview do
      type { Application::Events::Interview.name }
    end

    trait :application_note do
      type { Application::Events::Note.name }
    end

    trait :application_rejected do
      type { Application::Events::Rejected.name }
    end

    trait :application_hired do
      type { Application::Events::Hired.name }
    end

    trait :job_activated do
      type { Job::Events::Activated.name }
    end

    trait :job_deactivated do
      type { Job::Events::Deactivated.name }
    end
  end
end
