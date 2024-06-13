# frozen_string_literal: true

module Events
  module Processors
    class Base
      attr_reader :event, :params

      def initialize(event:, params:)
        @event = event
        @params = params
      end

      def process
        raise NotImplementedError
      end
    end
  end
end
