# frozen_string_literal: true

module Events
  module Processors
    module Applications
      class Rejected < Base
        def process
          event.initiable.rejected!
        end
      end
    end
  end
end
