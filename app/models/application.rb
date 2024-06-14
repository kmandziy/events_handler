# frozen_string_literal: true

class Application < ApplicationRecord
  belongs_to :job

  has_many :events, as: :initiable, dependent: :destroy

  has_many :rejected_events, as: :initiable, dependent: :destroy, class_name: Application::Events::Rejected.name
  has_many :hired_events, as: :initiable, dependent: :destroy, class_name: Application::Events::Hired.name

  has_many :notes, dependent: :destroy
  has_many :hires, dependent: :destroy
  has_many :interviews, dependent: :destroy

  enum status: { applied: 0, interview: 1, hired: 2, rejected: 3 }

  scope :ongoing_applications, -> { where.not(status: Application.statuses.values_at(:hired, :rejected)) }
  scope :with_activated_job, -> { joins(:job).merge(Job.activated) }

  scope :hired_applications, -> { hired }
  scope :rejected_applications, -> { rejected }
end
