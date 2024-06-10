# frozen_string_literal: true

module Events
  module Processors
    module Jobs
      class Deactivated < Base
        def process
          event.initiable.deactivated!
        end
      end
    end
  end
end
