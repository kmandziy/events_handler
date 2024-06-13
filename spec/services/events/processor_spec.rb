# frozen_string_literal: true

require 'rails_helper'

describe Events::Processor do
  subject(:event_processor) { described_class.new(params: params) }

  context 'when events are connected to application' do
    let(:application) { create(:application) }

    context 'when events type is interview' do
      let(:interview_date) { 1.day.from_now.to_s }
      let(:params) { { event_id: event.id, interview_date: interview_date } }
      let(:event) { create(:event, :application_interview, initiable: application) }

      before do
        event_processor.call
      end

      it 'changes application status' do
        expect(application.reload.status).to eq 'interview'
      end

      it 'creates interview record for this application with correct params' do
        expect(application.reload.interviews.last.interview_date).to eq interview_date
      end
    end

    context 'when events type is hire' do
      let(:hire_date) { 1.day.from_now.to_s }
      let(:params) { { event_id: event.id, hire_date: hire_date } }
      let(:event) { create(:event, :application_hired, initiable: application) }

      before do
        event_processor.call
      end

      it 'changes application status' do
        expect(application.reload.status).to eq 'hired'
      end

      it 'creates hire record for this application with correct params' do
        expect(application.reload.hires.last.hire_date).to eq hire_date
      end
    end

    context 'when events type is rejected' do
      let(:params) { { event_id: event.id } }
      let(:event) { create(:event, :application_rejected, initiable: application) }

      before do
        event_processor.call
      end

      it 'changes application status' do
        expect(application.reload.status).to eq 'rejected'
      end
    end

    context 'when events type is note' do
      let(:params) { { event_id: event.id, content: 'content' } }
      let(:event) { create(:event, :application_note, initiable: application) }

      before do
        event_processor.call
      end

      it 'does not change application status' do
        expect(application.reload.status).to eq 'applied'
      end

      it 'creates note record with expected content' do
        expect(application.reload.notes.last.content).to eq 'content'
      end
    end
  end

  context 'when events are connected to job' do
    context 'when events type is activated and job is deactivated' do
      let(:job) { create(:job) }
      let(:params) { { event_id: event.id } }
      let(:event) { create(:event, :job_activated, initiable: job) }

      it 'changes job status' do
        expect { event_processor.call }.to change { job.reload.status }.from('deactivated').to('activated')
      end
    end

    context 'when events type is deactivated and job is activated' do
      let(:job) { create(:job, :activated) }
      let(:params) { { event_id: event.id } }
      let(:event) { create(:event, :job_deactivated, initiable: job) }

      it 'changes job status' do
        expect { event_processor.call }.to change { job.reload.status }.from('activated').to('deactivated')
      end
    end
  end
end
