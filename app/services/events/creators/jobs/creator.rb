# frozen_string_literal: true

module Events
  module Creators
    module Jobs
      class Creator < Base
        SETTING = {
          activated: Job::Events::Activated,
          deactivated: Job::Events::Deactivated
        }.freeze

        def event_klass
          SETTING[event_type]
        end

        def initiable
          Job.find(params[:job_id])
        end

        def queue_name
          'jobs'
        end

        def route_name
          'jobs'
        end
      end
    end
  end
end
