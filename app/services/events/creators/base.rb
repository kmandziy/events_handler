# frozen_string_literal: true

module Events
  module Creators
    class Base
      attr_reader :event_type, :params, :event

      def initialize(params:)
        @params = params
        @event_type = params[:event_type].to_sym
      end

      def call
        check_for_errors
        create_event
        publish_event
      end

      def check_for_errors
        raise StandardError, "Wrong event type: #{event_type}" unless event_klass
      end

      def create_event
        @event = event_klass.create(initiable: initiable)
      end

      def publish_event
        Events::Publisher.new.publish({ event_id: event.id }.merge!(params), queue_name, route_name)
      end

      def event_klass
        raise NotImplementedError
      end

      def initiable
        raise NotImplementedError
      end
    end
  end
end
