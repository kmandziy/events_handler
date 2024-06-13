# frozen_string_literal: true

class ApplicationEventsController < ApplicationController
  def create
    service = Events::Creators::Applications::Creator.new(params: events_params)
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
    params.permit(:event_type, :application_id, :content, :hire_date, :interview_date)
  end
end
