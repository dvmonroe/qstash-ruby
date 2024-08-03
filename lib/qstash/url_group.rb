# frozen_string_literal: true

require "qstash/url_group/add_endpoints"
require "qstash/url_group/delete_endpoints"
require "qstash/url_group/get"
require "qstash/url_group/list"
require "qstash/url_group/delete"

module QStash
  module URLGroup
    class << self
      def add_endpoints(url_group_name, endpoints: [], headers: {})
        AddEndpoints.call(url_group_name, endpoints: endpoints, headers: headers)
      end

      def delete_endpoints(url_group_name, endpoints: [], headers: {})
        DeleteEndpoints.call(url_group_name, endpoints: endpoints, headers: headers)
      end

      def delete(url_group_name, headers: {})
        Delete.call(url_group_name, headers: headers)
      end

      def get(url_group_name, headers: {})
        Get.call(url_group_name, headers: headers)
      end

      def list(headers: {})
        List.call(headers: headers)
      end
    end

    private_constant :AddEndpoints, :DeleteEndpoints, :Get, :List, :Delete
  end
end
