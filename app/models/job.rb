class Job < ApplicationRecord
  has_many :events, as: :initiable

  enum status: { deactivated: 0, activated: 1 }
end
