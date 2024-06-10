# frozen_string_literal: true

module Events
  class Processor
    attr_reader :event

    PROCESSING_SETTINGS = {
      Job::Events::Activated => Events::Processors::Jobs::Activated,
      Job::Events::Deactivated => Events::Processors::Jobs::Deactivated,
      Application::Events::Hired => Events::Processors::Applications::Hired,
      Application::Events::Interview => Events::Processors::Applications::Interview,
      Application::Events::Rejected => Events::Processors::Applications::Rejected,
      Application::Events::Note => Events::Processors::Applications::Note
    }.freeze

    def initialize(event_id:)
      @event = Event.find(event_id)
    end

    def process
      processor_klass.new(event: event).process
    end

    def processor_klass
      PROCESSING_SETTINGS[event.class]
    end
  end
end
