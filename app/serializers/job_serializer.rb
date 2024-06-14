# frozen_string_literal: true

class JobSerializer < ActiveModel::Serializer
  attributes :id, :title, :hired_count, :rejected_count, :ongoing_applications_count

  def hired_count
    object.hired_events.count
  end

  def rejected_count
    object.rejected_events.count
  end

  def ongoing_applications_count
    object.applications.ongoing_applications.count
  end
end
