# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'job_events' do
  let(:connection) { BunnyMock.new }
  let(:job) { create(:job) }
  let(:channel) { connection.create_channel }

  before do
    allow(connection).to receive(:start)
    allow(Rabbitmq::Client.instance).to receive(:channel).and_return(channel)
  end

  path '/job_events' do
    post('create job_event') do
      let(:expected_data) { { 'initiable_type' => 'Job', 'initiable_id' => job.id } }
      let(:published_event_data) { JSON.parse(channel.queue('jobs').pop[:message]).with_indifferent_access }
      let(:expected_published_event_data) { params }

      tags 'Events / Job'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          event_type: { type: :string },
          job_id: { type: :integer },
          content: { type: :string },
          hire_date: { type: :string, format: 'date-time' },
          interview_date: { type: :string, format: 'date-time' }
        },
        required: %w[event_type job]
      }

      response(200, 'successful') do
        let(:params) do
          { job_id: job.id, event_type: 'activated' }
        end

        let(:event_klass) { Job::Events::Activated }

        it_behaves_like 'api response that matches with expected data'
        it_behaves_like 'like creates and publishes event'
      end

      response(200, 'successful') do
        let(:params) do
          { job_id: job.id, event_type: 'deactivated' }
        end

        let(:event_klass) { Job::Events::Deactivated }

        it_behaves_like 'api response that matches with expected data'
        it_behaves_like 'like creates and publishes event'
      end

      response(400, 'wrong event type') do
        let(:expected_data) { { 'message' => 'Wrong event type: wrong_type' } }
        let(:params) do
          { job_id: job.id, event_type: 'wrong_type', interview_date: Date.new(2024, 4, 4) }
        end

        it_behaves_like 'api response that matches with expected data'

        it 'does not create new event' do |example|
          expect { submit_request(example.metadata) }.not_to(change(Event, :count))
        end
      end
    end
  end
end
