# frozen_string_literal: true

class ApplicationsController < ApplicationController
  def index
    render json: {
      success: true,
      data: serialize_data(Application.all)
    }
  end

  def show
    application = Application.find(application_params[:id])

    render json: {
      success: true,
      data: serialize_data(application)
    }
  rescue StandardError => e
    render status: :bad_request, json: {
      success: false,
      data: {
        message: e.message
      }
    }
  end

  def application_params
    params.permit(:id)
  end
end
