# frozen_string_literal: true

module Events
  module Creators
    module Jobs
      class Activated < Base
        def call
          Job::Events::Activated.create(initiable: initiable)
        end
      end
    end
  end
end
