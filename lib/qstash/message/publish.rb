# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/publish
module QStash
  module Message
    class Publish
      include QStash::Callable
      include QStash::Requestable
      requestable method: :post

      attr_reader :destination, :body, :headers

      def initialize(destination:, body:, headers: {})
        @destination = destination
        @body = body
        @headers = headers
      end

      private

      def path_segment
        [Endpoints::PUBLISH_ENDPOINT, destination].join("/")
      end
    end
  end
end
