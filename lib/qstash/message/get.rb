# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/messages/get
module QStash
  module Message
    class Get
      include QStash::Callable
      attr_reader :message_id, :headers

      def initialize(message_id, headers: {})
        @message_id = message_id
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
          Endpoints::GET_ENDPOINT,
          message_id
        ].join("/")
      end
    end
  end
end
