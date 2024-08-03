# frozen_string_literal: true

module QStash
  class Response
    attr_reader :status, :headers, :body, :message

    def initialize(response)
      @status = response.code.to_i
      @headers = response.to_hash
      @message = response.message
      @body = begin
        JSON.parse(response.body)
      rescue JSON::ParserError
        response.body
      end
    end

    def inspect
      "#<#{self.class}:0x#{object_id.to_s(16)} #{status} #{message} readbody=true>"
    end
  end
end
