# frozen_string_literal: true

module Events
  module Creators
    class Base
      attr_reader :params

      def initialize(params:)
        @params = params
      end

      def call
        raise NotImplementedError
      end

      def event
        raise NotImplementedError
      end

      def initiable
        raise NotImplementedError
      end
    end
  end
end
