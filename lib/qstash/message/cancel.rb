# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/messages/cancel
# https://upstash.com/docs/qstash/api/messages/bulk-cancel
module QStash
  module Message
    class Cancel
      include QStash::Callable
      include QStash::Requestable

      requestable method: :delete

      attr_reader :message_ids, :headers

      def initialize(message_ids, headers: {})
        @message_ids = Array(message_ids)
        @headers = headers
      end

      private

      def path_segment
        (message_ids.length > 1) ? Endpoints::BULK_CANCEL_ENDPOINT : [Endpoints::CANCEL_ENDPOINT, message_ids.first].join("/")
      end

      def body
        (message_ids.length > 1) ? {messageIds: message_ids} : {}
      end
    end
  end
end
