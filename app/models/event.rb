class Event < ApplicationRecord
  belongs_to :initiable, polymorphic: true
end
