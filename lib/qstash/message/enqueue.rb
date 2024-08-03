# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/enqueue
module QStash
  module Message
    class Enqueue
      include QStash::Callable
      attr_reader :queue_name, :destination, :body, :headers

      def initialize(queue_name:, destination:, body:, headers: {})
        @queue_name = queue_name
        @destination = destination
        @body = body
        @headers = headers
      end

      def call
        uri = URI(endpoint)
        client = QStash::HttpClient.new(uri)
        client.post(body, headers)
      end

      private

      def endpoint
        [
          QStash.config.url.sub(/\/$/, ""),
          Endpoints::ENQUEUE_ENDPOINT,
          queue_name,
          destination
        ].join("/")
      end
    end
  end
end
