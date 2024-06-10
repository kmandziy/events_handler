# frozen_string_literal: true

module Events
  module Processors
    module Applications
      class Interview < Base
        def process
          event.initiable.interview!
        end
      end
    end
  end
end
