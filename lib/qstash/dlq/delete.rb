# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/dlq/deleteMessage
module QStash
  module DLQ
    class Delete
      include QStash::Callable
      attr_reader :dlq_ids, :headers

      def initialize(dlq_ids, headers: {})
        @dlq_ids = Array(dlq_ids)
        @headers = headers
      end

      def call
        uri = URI(endpoint)
        client = QStash::HttpClient.new(uri)
        client.delete(body, headers)
      end

      private

      def base_url
        QStash.config.url.sub(/\/$/, "")
      end

      def body
        (dlq_ids.length > 1) ? {dlqIds: dlq_ids} : {}
      end

      def endpoint
        [
          base_url,
          (dlq_ids.length > 1) ? Endpoints::DLQ_ENDPOINT : "#{Endpoints::DLQ_ENDPOINT}/#{dlq_ids.first}"
        ].join("/")
      end
    end
  end
end
