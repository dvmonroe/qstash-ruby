# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/dlq/getMessage
module QStash
  module DLQ
    class Get
      include QStash::Callable
      attr_reader :headers, :dlq_id

      def initialize(dlq_id, headers: {})
        @dlq_id = dlq_id
        @headers = headers
      end

      def call
        uri = URI(endpoint)
        client = QStash::HttpClient.new(uri)
        client.get(headers)
      end

      private

      def endpoint
        [
          QStash.config.url.sub(/\/$/, ""),
          Endpoints::DLQ_ENDPOINT,
          dlq_id
        ].join("/")
      end
    end
  end
end
