# frozen_string_literal: true

require "qstash/events/list"

module QStash
  module Events
    class << self
      def list(filters: {}, headers: {})
        List.call(filters: filters, headers: headers)
      end
    end

    private_constant :List
  end
end
