# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/url-groups/add-endpoint
module QStash
  module URLGroup
    class AddEndpoints
      include QStash::Callable
      include QStash::Requestable
      requestable method: :post

      attr_reader :url_group_name, :endpoints, :headers

      def initialize(url_group_name:, endpoints: [], headers: {})
        @url_group_name = url_group_name
        @endpoints = endpoints
        @headers = headers
      end

      private

      def path_segment
        [Endpoints::URL_GROUPS_ENDPOINT, url_group_name, "endpoints"].join("/")
      end

      def body
        {endpoints: endpoints}
      end
    end
  end
end
