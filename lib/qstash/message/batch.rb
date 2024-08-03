# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/messages/batch
module QStash
  module Message
    class Batch
      include QStash::Callable
      include QStash::Requestable
      requestable method: :post

      attr_reader :messages, :headers

      def initialize(messages, headers: {})
        @messages = messages
        @headers = headers
      end

      private

      def path_segment
        Endpoints::BATCH_ENDPOINT
      end

      def body
        messages
      end
    end
  end
end
