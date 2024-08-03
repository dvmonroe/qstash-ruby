# frozen_string_literal: true

require "qstash/message/publish"
require "qstash/message/enqueue"
require "qstash/message/batch"
require "qstash/message/get"
require "qstash/message/cancel"

module QStash
  module Message
    class << self
      def batch(messages, headers: {})
        Batch.call(messages, headers: headers)
      end

      def cancel(message_ids, headers: {})
        Cancel.call(message_ids, headers: headers)
      end

      def enqueue(queue_name:, destination:, body:, headers: {})
        Enqueue.call(queue_name: queue_name, destination: destination, body: body, headers: headers)
      end

      def get(message_id, headers: {})
        Get.call(message_id, headers: headers)
      end

      def publish(destination:, body:, headers: {})
        Publish.call(destination: destination, body: body, headers: headers)
      end
    end

    private_constant :Publish, :Enqueue, :Batch, :Get, :Cancel
  end
end
