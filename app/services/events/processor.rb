# frozen_string_literal: true

module Events
  class Processor
    attr_reader :event

    PROCESSING_SETTINGS = {
      Job::Events::Activated => Processors::Jobs::Activated,
      Job::Events::Deactivated => Processors::Jobs::Deactivated,
      Application::Events::Hired => Processors::Applications::Hired,
      Application::Events::Interview => Processors::Applications::Interview,
      Application::Events::Rejected => Processors::Applications::Rejected
    }.freeze

    SKIP_PROCESSING_EVENTS_LIST = [Application::Events::Note].freeze

    def initialize(event_id:)
      @event = Event.find(event_id)
    end

    def process
      return if SKIP_PROCESSING_EVENTS_LIST.include?(event.class)

      processor_klass.new(event: event).process
    end

    def processor_klass
      PROCESSING_SETTINGS[event.class]
    end
  end
end
