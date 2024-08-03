module QStash
  module Configuration
    extend self

    def token
      Thread.current[:qstash_token] || ENV.fetch("QSTASH_TOKEN", "")
    end

    def token=(value)
      Thread.current[:qstash_token] = value
    end

    def url
      Thread.current[:qstash_url] || ENV.fetch("QSTASH_URL", "https://qstash.upstash.io")
    end

    def url=(value)
      Thread.current[:qstash_url] = value
    end

    def configure
      yield self
    end
  end
end
