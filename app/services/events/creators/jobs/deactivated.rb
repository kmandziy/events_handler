# frozen_string_literal: true

module Events
  module Creators
    module Jobs
      class Deactivated < Base
        def call
          Job::Events::Deactivated.create(initiable: initiable)
        end
      end
    end
  end
end
