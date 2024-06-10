# frozen_string_literal: true

module Events
  module Processors
    module Jobs
      class Activated < Base
        def process
          event.initiable.activated!
        end
      end
    end
  end
end
