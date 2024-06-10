# frozen_string_literal: true

module Rabbitmq
  class Connection
    include Singleton

    attr_reader :connection, :channel

    def initialize
      @connection = Bunny.new(connection_options)
      @connection.start
      @channel = connection.create_channel
    end

    def close
      channel.close if channel.open?
      connection.close if connection.open?
    end

    def connection_options
      { username: 'event_handler_backend_user', password: 'dkksdkkskqwj', automatically_recover: true,
        host: ENV['RABBITMQ_HOST'] || 'localhost' }
    end
  end
end
