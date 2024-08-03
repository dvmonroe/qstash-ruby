# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/signingKeys/get
module QStash
  module SigningKeys
    class Get
      include QStash::Callable
      include QStash::Requestable

      requestable method: :get

      attr_reader :headers

      def initialize(headers: {})
        @headers = headers
      end

      private

      def path_segment
        Endpoints::SIGNING_KEYS_ENDPOINT
      end
    end
  end
end
