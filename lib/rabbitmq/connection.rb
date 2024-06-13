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
      {
        username: creds_for(:username),
        password: creds_for(:password),
        host: creds_for(:host),
        automatically_recover: true
      }
    end

    def creds_for(key)
      Rails.application.credentials.dig(Rails.env.to_sym, :rabbitmq, key)
    end
  end
end
