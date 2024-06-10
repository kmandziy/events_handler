# frozen_string_literal: true

class Application < ApplicationRecord
  has_many :events, as: :initiable, dependent: :destroy

  has_many :notes, dependent: :destroy
  has_many :hires, dependent: :destroy
  has_many :interviews, dependent: :destroy

  enum status: { applied: 0, interview: 1, hired: 2, rejected: 3 }
end
