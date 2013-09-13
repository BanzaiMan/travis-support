require 'march_hare'

module Travis
  module Amqp
    autoload :Consumer,        'travis/support/amqp/march_hare/consumer'
    autoload :Publisher,       'travis/support/amqp/march_hare/publisher'
    autoload :FanoutPublisher, 'travis/support/amqp/march_hare/publisher'

    class << self
      def config
        @config ||= {}
      end

      def config=(config)
        @config = config
      end

      def connected?
        !!@connection
      end

      def connection
        @connection ||= MarchHare.connect(config)
      end
      alias :connect :connection

      def disconnect
        if connection
          connection.close if connection.isOpen
          @connection = nil
        end
      end
    end
  end
end
