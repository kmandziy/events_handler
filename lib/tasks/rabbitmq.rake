# frozen_string_literal: true

namespace :rabbitmq do
  desc 'Start subscriber'

  task subscribe: :environment do
    Events::Subscriber.start('jobs')
  end
end
