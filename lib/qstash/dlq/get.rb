# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/dlq/getMessage
module QStash
  module DLQ
    class Get
      include QStash::Requestable
      include QStash::Callable

      requestable method: :get

      attr_reader :dlq_id, :headers

      def initialize(dlq_id, headers: {})
        @dlq_id = dlq_id
        @headers = headers
      end

      private

      def path_segment
        [Endpoints::DLQ_ENDPOINT, dlq_id].join("/")
      end

      def body
        nil
      end
    end
  end
end
