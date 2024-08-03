# frozen_string_literal: true

module QStash
  module Requestable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      DEFAULT_REQUEST_METHODS = %i[get post delete].freeze

      private

      def requestable(**options)
        method = options.fetch(:method, DEFAULT_REQUEST_METHODS)
        define_http_method(method)
      end

      def define_http_method(method)
        define_method(:http_method) do
          method
        end
      end
    end

    def call(**args)
      uri = URI(endpoint)
      client = QStash::HttpClient.new(uri)
      if http_method == :get
        client.send(http_method, headers)
      else
        client.send(http_method, body, headers)
      end
    end

    private

    def base_url
      QStash.config.url.sub(/\/$/, "")
    end

    def endpoint
      [
        base_url,
        path_segment
      ].join("/")
    end

    def path_segment
      raise NotImplementedError, "#{self.class} must implement #path_segment"
    end

    def body
      raise NotImplementedError, "#{self.class} must implement #body"
    end

    def headers
      raise NotImplementedError, "#{self.class} must implement #headers"
    end
  end
end
