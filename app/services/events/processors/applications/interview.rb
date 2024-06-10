# frozen_string_literal: true

module Events
  module Processors
    module Applications
      class Interview < Base
        def process
          application = event.initiable
          application.interview!
          application.interviews.create(interview_date: params[:hire_date])
        end
      end
    end
  end
end
