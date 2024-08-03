# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/url-groups/get
module QStash
  module URLGroup
    class Get
      include QStash::Callable
      include QStash::Requestable
      requestable method: :get

      attr_reader :url_group_name, :headers

      def initialize(url_group_name, headers: {})
        @url_group_name = url_group_name
        @headers = headers
      end

      private

      def path_segment
        [Endpoints::URL_GROUPS_ENDPOINT, url_group_name].join("/")
      end

      def body
        nil
      end
    end
  end
end
