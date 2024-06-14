# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'applications' do
  let!(:application) { create(:application, job: job) }
  let!(:job) { create(:job, :activated) }

  let(:expected_data) do
    {
      'id' => application.id,
      'job_title' => application.job.title,
      'candidate_name' => application.candidate_name,
      'status' => 'applied',
      'interview_date' => nil,
      'notes_count' => 0,
      'rejected_count' => 0
    }
  end

  path '/applications' do
    get('list applications') do
      response(200, 'successful') do
        it_behaves_like 'api response that matches with expected data'
      end
    end
  end

  path '/applications/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show application') do
      response(200, 'successful') do
        let(:id) { application.id }

        it_behaves_like 'api response that matches with expected data'
      end
    end
  end
end
