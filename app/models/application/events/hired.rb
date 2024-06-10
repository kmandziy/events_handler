# frozen_string_literal: true

class Application
  module Events
    class Hired < Event
      def routing_key
        'applications'
      end

      def queue_name
        'applications'
      end
    end
  end
end
