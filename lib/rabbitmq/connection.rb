# frozen_string_literal: true

module Rabbitmq
  class Connection
    include Singleton
    def initialize
      connection.start
    end

    def connection
      @connection ||= Bunny.new(connection_options)
    end

    def channel
      @channel ||= connection.create_channel
    end

    def close
      channel.close if channel.open?
      connection.close if connection.open?
    end

    def connection_options
      {
        username: creds_for(:username),
        password: creds_for(:password),
        host: creds_for(:host),
        automatically_recover: true
      }
    end

    def creds_for(key)
      Rails.application.credentials.dig(:rabbitmq, key)
    end
  end
end
