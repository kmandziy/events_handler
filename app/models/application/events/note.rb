# frozen_string_literal: true

class Application
  module Events
    class Note < Event
      def routing_key
        'applications'
      end

      def queue_name
        'applications'
      end
    end
  end
end
