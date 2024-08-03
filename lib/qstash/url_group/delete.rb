# frozen_string_literal: true

# https://upstash.com/docs/qstash/api/url-groups/remove
module QStash
  module URLGroup
    class Delete
      include QStash::Callable
      include QStash::Requestable
      requestable method: :delete

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
        {}
      end
    end
  end
end
