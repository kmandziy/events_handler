class Interview < ApplicationRecord
  belongs_to :application
  has_many :events, as: :initiable
end
