# frozen_string_literal: true

module Events
  class Subscriber
    attr_reader :queue_name

    def self.start(queue_name)
      channel = ::Rabbitmq::Client.instance.channel
      queue = channel.queue(queue_name, durable: true)
      subscribe_queue(queue)
    rescue Interrupt => _e
      channel.close
      Connection.instance.close
    end

    def subscribe_queue(queue)
      queue.subscribe(block: true, manual_ack: true) do |delivery_info, _properties, body|
        handle_message(body)

        channel.ack(delivery_info.delivery_tag)
      rescue StandardError => e
        Rails.logger.debug { "Error processing message: #{e.message}" }

        channel.nack(delivery_info.delivery_tag, false, false)
      end
    end

    def self.handle_message(body)
      Rails.logger.debug { "Received message: #{body}" }
    end
  end
end
