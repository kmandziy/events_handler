# frozen_string_literal: true

RSpec.shared_examples 'api response that matches with expected data' do
  run_test! do |response|
    parsed_data = JSON.parse(response.body)['data']

    expect(parsed_data).to include(expected_data)
  end
end

RSpec.shared_examples 'like creates and publishes event' do
  it 'creates new event' do |example|
    expect { submit_request(example.metadata) }.to(change(event_klass, :count))
  end

  it 'publishes expected data' do |example|
    submit_request(example.metadata)

    expect(published_event_data).to include(expected_published_event_data)
  end
end
