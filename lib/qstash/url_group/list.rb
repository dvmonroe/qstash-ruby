# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/url-groups/list
module QStash
  module URLGroup
    class List
      include QStash::Callable
      include QStash::Requestable
      requestable method: :get

      attr_reader :headers

      def initialize(headers: {})
        @headers = headers
      end

      private

      def path_segment
        Endpoints::URL_GROUPS_ENDPOINT
      end

      def body
        nil
      end
    end
  end
end
