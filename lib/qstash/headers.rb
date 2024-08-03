# frozen_string_literal: true

module QStash
  module Headers
    extend self

    def qstash_header_key(key)
      case key.to_sym
      when :content_type
        "Content-Type"
      when :upstash_method
        "Upstash-Method"
      when :upstash_timeout
        "Upstash-Timeout"
      when :upstash_retries
        "Upstash-Retries"
      when :upstash_callback
        "Upstash-Callback"
      when :upstash_failure_callback
        "Upstash-Failure-Callback"
      when /^upstash_forward_/
        "Upstash-Forward-#{key.to_s.gsub(/^upstash_forward_/, "").camelize(:lower)}"
      when :upstash_delay
        "Upstash-Delay"
      when :upstash_not_before
        "Upstash-Not-Before"
      when :upstash_deduplication_id
        "Upstash-Deduplication-Id"
      when :upstash_content_based_deduplication
        "Upstash-Content-Based-Deduplication"
      else
        key.to_s
      end
    end
  end
end
