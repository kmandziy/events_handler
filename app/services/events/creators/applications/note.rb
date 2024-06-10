# frozen_string_literal: true

module Events
  module Creators
    module Applications
      class Note < Base
        def call
          Application::Events::Note.create(initiable: initiable)
        end
      end
    end
  end
end
