# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/dlq/deleteMessage
module QStash
  module DLQ
    class Delete
      include QStash::Callable
      include QStash::Requestable
      requestable method: :delete

      attr_reader :dlq_ids, :headers

      def initialize(dlq_ids, headers: {})
        @dlq_ids = Array(dlq_ids)
        @headers = headers
      end

      private

      def path_segment
        (dlq_ids.length > 1) ? Endpoints::DLQ_ENDPOINT : [Endpoints::DLQ_ENDPOINT, dlq_ids.first].join("/")
      end

      def body
        (dlq_ids.length > 1) ? {dlqIds: dlq_ids} : {}
      end
    end
  end
end
