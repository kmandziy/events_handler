# frozen_string_literal: true

namespace :rabbitmq do
  desc 'Start subscriber'

  task subscribe_applications: :environment do
    Events::Subscriber.start('applications')
  end

  task subscribe_jobs: :environment do
    Events::Subscriber.start('jobs')
  end
end
