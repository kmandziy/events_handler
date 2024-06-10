# frozen_string_literal: true

module Events
  module Processors
    class Base
      attr_reader :event

      def initialize(event:)
        @event = event
      end

      def process
        raise NotImplementedError
      end
    end
  end
end
