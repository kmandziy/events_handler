# frozen_string_literal: true

module Events
  class Publisher
    attr_reader :channel

    def initialize(channel = ::Rabbitmq::Client.instance.channel)
      @channel = channel
    end

    def publish(payload, queue_name, routing_key)
      queue = channel.queue(queue_name, durable: true)
      queue.publish(payload.to_json, routing_key: routing_key, persistent: true)
    end
  end
end
