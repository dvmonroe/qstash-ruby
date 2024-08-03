# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/dlq/listMessages
module QStash
  module DLQ
    class List
      include QStash::Callable
      attr_reader :filters, :headers

      def initialize(filters: {}, headers: {})
        @filters = filters
        @headers = headers
      end

      def call
        uri = URI(endpoint)
        client = QStash::HttpClient.new(uri)
        client.get(headers)
      end

      private

      def endpoint
        url = [
          QStash.config.url.sub(/\/$/, ""),
          Endpoints::DLQ_ENDPOINT
        ].join("/")

        # Add query params from filters hash
        url += "?#{URI.encode_www_form(filters)}" unless filters.empty?

        url
      end
    end
  end
end
