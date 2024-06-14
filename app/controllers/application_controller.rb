# frozen_string_literal: true

class ApplicationController < ActionController::API
  def serialize_data(relation)
    ActiveModelSerializers::SerializableResource.new(relation)
  end
end
