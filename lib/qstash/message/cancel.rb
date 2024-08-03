# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/messages/cancel
# https://upstash.com/docs/qstash/api/messages/bulk-cancel
module QStash
  module Message
    class Cancel
      include QStash::Callable
      attr_reader :message_ids, :headers

      def initialize(message_ids, headers: {})
        @message_ids = Array(message_ids)
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
        (message_ids.length > 1) ? {messageIds: message_ids} : {}
      end

      def endpoint
        [
          base_url,
          (message_ids.length > 1) ? Endpoints::BULK_CANCEL_ENDPOINT : "#{Endpoints::CANCEL_ENDPOINT}/#{message_ids.first}"
        ].join("/")
      end
    end
  end
end
