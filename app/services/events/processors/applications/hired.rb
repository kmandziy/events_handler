# frozen_string_literal: true

module Events
  module Processors
    module Applications
      class Hired < Base
        def process
          event.initiable.hired!
        end
      end
    end
  end
end
