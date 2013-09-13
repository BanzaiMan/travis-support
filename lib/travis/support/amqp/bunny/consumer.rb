module Travis
  module Amqp
    class Consumer
      def initialize
        raise 'AMQP Bunny consumer is not avialable or recommended for use, consider using march_hare'
      end
    end
  end
end
