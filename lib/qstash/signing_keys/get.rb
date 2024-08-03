# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/signingKeys/get
module QStash
  module SigningKeys
    class Get
      include QStash::Callable
      attr_reader :headers

      def initialize(headers: {})
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
          Endpoints::SIGNING_KEYS_ENDPOINT
        ].join("/")
      end
    end
  end
end
