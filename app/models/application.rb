class Application < ApplicationRecord
  has_many :notes
  has_many :hires
  has_many :interviews

  has_many :note_events, through: :notes, source: :events
  has_many :hire_events, through: :hires, source: :events
  has_many :interview_events, through: :interview, source: :events

  enum status: { applied: 0, interview: 1, hired: 2, rejected: 3 }
end
