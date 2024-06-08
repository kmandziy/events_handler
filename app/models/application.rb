class Application < ApplicationRecord
  has_many :events, as: :initiable

  has_many :notes
  has_many :hires
  has_many :interviews

  enum status: { applied: 0, interview: 1, hired: 2, rejected: 3 }
end
