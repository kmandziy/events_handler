# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'jobs' do
  let!(:job) { create(:job) }

  let(:expected_data) do
    {
      'id' => job.id,
      'title' => job.title,
      'hired_count' => 0,
      'ongoing_applications_count' => 0,
      'rejected_count' => 0
    }
  end

  path '/jobs' do
    get('list jobs') do
      response(200, 'successful') do
        it_behaves_like 'api response that matches with expected data'
      end
    end
  end

  path '/jobs/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show job') do
      response(200, 'successful') do
        let(:id) { job.id }

        it_behaves_like 'api response that matches with expected data'
      end
    end
  end
end
