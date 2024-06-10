# frozen_string_literal: true

module Job
  module Events
    class Deactivated < Event
      def routing_key
        'jobs'
      end

      def queue_name
        'jobs'
      end
    end
  end
end
