# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/signingKeys/rotate
module QStash
  module SigningKeys
    class Rotate
      include QStash::Callable
      attr_reader :headers

      def initialize(headers: {})
        @headers = headers
      end

      def call
        uri = URI(endpoint)
        client = QStash::HttpClient.new(uri)
        client.post({}, headers)
      end

      private

      def endpoint
        [
          QStash.config.url.sub(/\/$/, ""),
          Endpoints::ROTATE_SIGNING_KEY_ENDPOINT
        ].join("/")
      end
    end
  end
end
