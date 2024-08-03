# frozen_string_literal: true

require "json"
require "net/http"
require "uri"

require "qstash/version"
require "qstash/configuration"
require "qstash/headers"
require "qstash/http_client"
require "qstash/response"
require "qstash/callable"
require "qstash/endpoints"

require "qstash/message"
require "qstash/events"
require "qstash/signing_keys"
require "qstash/dlq"

module QStash
  class Error < StandardError; end

  class << self
    def configure
      yield Configuration
    end

    def configuration
      Configuration
    end

    alias_method :config, :configuration
  end
end
