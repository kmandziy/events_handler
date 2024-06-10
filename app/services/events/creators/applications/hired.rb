# frozen_string_literal: true

module Events
  module Creators
    module Applications
      class Hired < Base
        def call
          Application::Events::Hired.create(initiable: initiable)
        end
      end
    end
  end
end
