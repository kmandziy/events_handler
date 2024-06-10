# frozen_string_literal: true

module Rabbitmq
  class Client
    include Singleton

    APPLICATION_EXCHANGE = 'event_handling.exchange'

    def start
      setup_exchanges_and_queues
    end

    def channel
      @channel ||= Connection.instance.channel
    end

    def exchange
      @exchange ||= channel.direct(APPLICATION_EXCHANGE, durable: true)
    end

    def setup_exchanges_and_queues
      bind_queue('jobs')
      bind_queue('applications')
    end

    def bind_queue(name)
      queue = channel.queue(name, durable: true)
      queue.bind(exchange, routing_key: name)
    end

    at_exit do
      Connection.instance.close
    end
  end
end
