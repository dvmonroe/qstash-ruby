# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/publish
module QStash
  module Message
    class Publish
      include QStash::Callable
      attr_reader :destination, :body, :headers

      def initialize(destination:, body:, headers: {})
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
          Endpoints::PUBLISH_ENDPOINT,
          destination
        ].join("/")
      end
    end
  end
end
