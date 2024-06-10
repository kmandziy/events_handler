# frozen_string_literal: true

module Events
  module Creators
    module Applications
      class Rejected < Base
        def call
          Application::Events::Rejected.create(initiable: initiable)
        end
      end
    end
  end
end
