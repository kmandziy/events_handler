# frozen_string_literal: true

module Events
  class Processor
    attr_reader :event, :params

    PROCESSING_SETTINGS = {
      Job::Events::Activated => Events::Processors::Jobs::Activated,
      Job::Events::Deactivated => Events::Processors::Jobs::Deactivated,
      Application::Events::Hired => Events::Processors::Applications::Hired,
      Application::Events::Interview => Events::Processors::Applications::Interview,
      Application::Events::Rejected => Events::Processors::Applications::Rejected,
      Application::Events::Note => Events::Processors::Applications::Note
    }.freeze

    def initialize(params:)
      @event = Event.find(params[:event_id])
      @params = params
    end

    def call
      processor_klass.new(event: event, params: params).process
    end

    def processor_klass
      PROCESSING_SETTINGS[event.class]
    end
  end
end
