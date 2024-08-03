# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/dlq/listMessages
module QStash
  module DLQ
    class List
      include QStash::Callable
      include QStash::Requestable

      requestable method: :get

      attr_reader :filters, :headers

      def initialize(filters: {}, headers: {})
        @filters = filters
        @headers = headers
      end

      private

      def path_segment
        Endpoints::DLQ_ENDPOINT
      end

      def body
        nil
      end
    end
  end
end
