# frozen_string_literal: true

class Job < ApplicationRecord
  has_many :events, as: :initiable, dependent: :destroy

  enum status: { deactivated: 0, activated: 1 }
end
