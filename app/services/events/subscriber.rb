# frozen_string_literal: true

module Events
  class Subscriber
    attr_reader :queue_name

    def self.start(queue_name)
      queue = channel.queue(queue_name, durable: true)
      subscribe_queue(queue)
    rescue Interrupt => _e
      ::Rabbitmq::Connection.instance.close
    end

    def self.subscribe_queue(queue)
      queue.subscribe(block: true, manual_ack: true) do |_delivery_info, _properties, body|
        params = JSON.parse(body).with_indifferent_access
        service = ::Events::Processor.new(params: params)
        service.call
        Rails.logger.debug { "Event #{service.event.type} successfuly processed" }
        Rails.logger.debug { "Initiable Status: #{service.event.initiable.status}" }
      rescue StandardError => e
        Rails.logger.debug { "Error processing message: #{e.message}" }
      end
    end

    def self.channel
      @channel ||= ::Rabbitmq::Client.instance.channel
    end

    def self.handle_message(body)
      Rails.logger.debug { "Received message: #{body}" }
    end
  end
end
