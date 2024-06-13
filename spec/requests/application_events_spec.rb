# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'application_events' do
  let(:connection) { BunnyMock.new }
  let(:application) { create(:application) }
  let(:channel) { connection.create_channel }

  before do
    allow(connection).to receive(:start)
    allow(Rabbitmq::Client.instance).to receive(:channel).and_return(channel)
  end

  path '/application_events' do
    post('create application_event') do
      let(:expected_data) { { 'initiable_type' => 'Application', 'initiable_id' => application.id } }
      let(:published_event_data) { JSON.parse(channel.queue('applications').pop[:message]).with_indifferent_access }
      let(:expected_published_event_data) { params }

      tags 'Events / Application'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          event_type: { type: :string },
          application_id: { type: :integer },
          content: { type: :string },
          hire_date: { type: :string, format: 'date-time' },
          interview_date: { type: :string, format: 'date-time' }
        },
        required: %w[event_type application_id]
      }

      response(200, 'successful') do
        let(:params) do
          { application_id: application.id, event_type: 'interview', interview_date: Date.new(2024, 4, 4).to_s }
        end

        let(:event_klass) { Application::Events::Interview }

        it_behaves_like 'api response that matches with expected data'
        it_behaves_like 'like creates and publishes event'
      end

      response(200, 'successful') do
        let(:params) do
          { application_id: application.id, event_type: 'hired', hire_date: Date.new(2024, 4, 4).to_s }
        end

        let(:event_klass) { Application::Events::Hired }

        it_behaves_like 'api response that matches with expected data'
        it_behaves_like 'like creates and publishes event'
      end

      response(200, 'successful') do
        let(:params) do
          { application_id: application.id, event_type: 'note', content: 'content' }
        end

        let(:event_klass) { Application::Events::Note }

        it_behaves_like 'api response that matches with expected data'
        it_behaves_like 'like creates and publishes event'
      end

      response(200, 'successful') do
        let(:params) do
          { application_id: application.id, event_type: 'rejected' }
        end

        let(:event_klass) { Application::Events::Rejected }

        it_behaves_like 'api response that matches with expected data'
        it_behaves_like 'like creates and publishes event'
      end

      response(400, 'wrong event type') do
        let(:expected_data) { { 'message' => 'Wrong event type: wrong_type' } }
        let(:params) do
          { application_id: application.id, event_type: 'wrong_type', interview_date: Date.new(2024, 4, 4) }
        end

        it_behaves_like 'api response that matches with expected data'

        it 'does not create new event' do |example|
          expect { submit_request(example.metadata) }.not_to(change(Event, :count))
        end
      end
    end
  end
end
