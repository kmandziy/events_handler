# frozen_string_literal: true

class JobEventsController < ApplicationController
  def create
    service = Events::Creators::Jobs::Creator.new(params: events_params)
    service.call

    render json: {
      success: true,
      data: service.event.serializable_hash
    }
  rescue StandardError => e
    render status: :bad_request, json: {
      success: false,
      data: {
        message: e.message
      }
    }
  end

  def events_params
    params.permit(:event_type, :job_id)
  end
end
