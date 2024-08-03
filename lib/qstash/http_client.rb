# frozen_string_literal: true

module QStash
  class HttpClient
    attr_reader :uri

    def initialize(uri)
      @uri = uri
    end

    def delete(body, headers = {})
      request = Net::HTTP::Delete.new(uri)
      request.body = body.to_json
      set_headers(request, headers)

      make_request(request)
    end

    def get(headers = {})
      request = Net::HTTP::Get.new(uri)
      set_headers(request, headers)

      make_request(request)
    end

    def post(body, headers = {})
      request = Net::HTTP::Post.new(uri)
      request.body = body.to_json
      set_headers(request, headers)

      make_request(request)
    end

    private

    def make_request(request)
      request["Authorization"] = "Bearer #{QStash.config.token}"
      request["User-Agent"] = "qstash-rb/#{QStash::VERSION}"

      Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
        http.request(request).then do |response|
          Response.new(response)
        end
      end
    end

    def set_headers(request, headers)
      headers.each do |key, value|
        request[QStash::Headers.qstash_header_key(key)] = value
      end
    end
  end
end
