# frozen_string_literal: true

module Events
  module Creators
    module Applications
      class Creator < Base
        SETTING = {
          interview: Application::Events::Interview,
          hired: Application::Events::Hired,
          note: Application::Events::Note,
          rejected: Application::Events::Rejected
        }.freeze

        def event_klass
          SETTING[event_type]
        end

        def initiable
          Application.find(params[:application_id])
        end

        def queue_name
          'applications'
        end

        def route_name
          'applications'
        end
      end
    end
  end
end
