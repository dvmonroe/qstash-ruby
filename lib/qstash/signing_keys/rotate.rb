# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/signingKeys/rotate
module QStash
  module SigningKeys
    class Rotate
      include QStash::Requestable
      include QStash::Callable

      requestable method: :post

      attr_reader :headers

      def initialize(headers: {})
        @headers = headers
      end

      private

      def path_segment
        Endpoints::ROTATE_SIGNING_KEY_ENDPOINT
      end

      def body
        {}
      end
    end
  end
end
