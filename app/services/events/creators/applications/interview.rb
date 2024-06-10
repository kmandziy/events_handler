# frozen_string_literal: true

module Events
  module Creators
    module Applications
      class Interview < Base
        def call
          Application::Events::Interview.create(initiable: initiable)
        end
      end
    end
  end
end
