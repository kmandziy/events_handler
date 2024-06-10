# frozen_string_literal: true

module Events
  module Creators
    class Base < Base
      def initiable
        Application.find(params[:application_id])
      end
    end
  end
end
