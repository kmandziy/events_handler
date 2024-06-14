# frozen_string_literal: true

class ApplicationSerializer < ActiveModel::Serializer
  attributes :id, :job_title, :candidate_name, :status, :interview_date, :notes_count, :rejected_count

  def notes_count
    object.notes.count
  end

  def job_title
    object.job.title
  end

  def rejected_count
    object.rejected_events.count
  end

  def hired_count
    object.hired_events.count
  end

  def interview_date
    object.interviews.last&.interview_date
  end
end
