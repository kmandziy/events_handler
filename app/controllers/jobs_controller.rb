# frozen_string_literal: true

class JobsController < ApplicationController
  def index
    render json: {
      success: true,
      data: serialize_data(Job.all)
    }
  end

  def show
    job = Job.find(job_params[:id])

    render json: {
      success: true,
      data: serialize_data(job)
    }
  rescue StandardError => e
    render status: :bad_request, json: {
      success: false,
      data: {
        message: e.message
      }
    }
  end

  def job_params
    params.permit(:id)
  end
end
