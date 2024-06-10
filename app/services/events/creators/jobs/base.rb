# frozen_string_literal: true

module Events
  module Creators
    class Base < Base
      def initiable
        Job.find(params[:job_id])
      end
    end
  end
end
