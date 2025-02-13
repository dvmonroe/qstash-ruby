# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/events/list
module QStash
  module Events
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
        Endpoints::LIST_EVENTS_ENDPOINT
      end

      def body
        nil
      end
    end
  end
end
