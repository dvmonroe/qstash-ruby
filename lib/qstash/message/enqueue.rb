# frozen_string_literal: true

module QStash
  module Message
    class Enqueue
      include QStash::Callable
      include QStash::Requestable

      requestable method: :post

      attr_reader :messages, :headers

      def initialize(queue_name:, destination:, body:, headers: {})
        @queue_name = queue_name
        @destination = destination
        @body = body
        @headers = headers
      end

      private

      def path_segment
        [
          Endpoints::ENQUEUE_ENDPOINT,
          queue_name,
          destination
        ].join("/")
      end
    end
  end
end
