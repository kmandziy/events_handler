# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :initiable, polymorphic: true

  after_create :publish_event

  def publish_event
    # Events::Publisher.new.publish({ event_id: id }, queue_name, routing_key)
  end

  def routing_key
    'default'
  end

  def queue_name
    'default'
  end
end
