require "qstash/dlq/get"
require "qstash/dlq/list"
require "qstash/dlq/delete"

module QStash
  module DLQ
    class << self
      def get(dlq_id, headers: {})
        Get.call(dlq_id, headers: headers)
      end

      def list(filters: {}, headers: {})
        List.call(filters: filters, headers: headers)
      end

      def delete(dlq_id, headers: {})
        Delete.call(dlq_id, headers: headers)
      end
    end

    private_constant :Get, :List, :Delete
  end
end
