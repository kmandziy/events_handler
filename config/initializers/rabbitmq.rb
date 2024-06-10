# frozen_string_literal: true

require 'bunny'

require_relative '../../lib/rabbitmq/connection'
require_relative '../../lib/rabbitmq/client'

Rabbitmq::Client.instance.start
