# frozen_string_literal: true

module Events
  module Processors
    module Applications
      class Hired < Base
        def process
          application = event.initiable
          application.hired!
          application.hires.create(hire_date: params[:hire_date])
        end
      end
    end
  end
end
