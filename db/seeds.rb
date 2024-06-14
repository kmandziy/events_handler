# frozen_string_literal: true

10.times do
  active_job = FactoryBot.create(:job, :activated)
  FactoryBot.create(:application, job: active_job)
end

10.times do
  FactoryBot.create(:application)
end
