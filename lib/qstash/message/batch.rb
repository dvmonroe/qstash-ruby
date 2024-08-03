# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/messages/batch
module QStash
  module Message
    class Batch
      include QStash::Callable
      attr_reader :messages, :headers

      def initialize(messages:, headers: {})
        @messages = messages
        @headers = headers
      end

      def call
        uri = URI(endpoint)
        client = QStash::HttpClient.new(uri)
        client.post(messages, headers)
      end

      private

      def endpoint
        [
          QStash.config.url.sub(/\/$/, ""),
          Endpoints::BATCH_ENDPOINT
        ].join("/")
      end
    end
  end
end
