# frozen_string_literal: true

require "qstash/signing_keys/get"
require "qstash/signing_keys/rotate"

module QStash
  module SigningKeys
    class << self
      def get(headers: {})
        Get.call(headers: headers)
      end

      def rotate(headers: {})
        Rotate.call(headers: headers)
      end
    end

    private_constant :Get, :Rotate
  end
end
