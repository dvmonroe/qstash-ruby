# frozen_string_literal: true

module QStash
  module Endpoints
    VERSION = "v2"

    # Messages
    ENQUEUE_ENDPOINT = "#{VERSION}/enqueue"
    PUBLISH_ENDPOINT = "#{VERSION}/publish"
    BATCH_ENDPOINT = "#{VERSION}/batch"
    GET_ENDPOINT = "#{VERSION}/messages"
    CANCEL_ENDPOINT = "#{VERSION}/messages"
    BULK_CANCEL_ENDPOINT = "#{VERSION}/messages"

    # Events
    LIST_EVENTS_ENDPOINT = "#{VERSION}/events"

    # Signing Keys
    ROTATE_SIGNING_KEY_ENDPOINT = "#{VERSION}/keys/rotate"
    SIGNING_KEYS_ENDPOINT = "#{VERSION}/keys"

    # Dead Letter Queue
    DLQ_ENDPOINT = "#{VERSION}/dlq"

    # URL Groups
    URL_GROUPS_ENDPOINT = "#{VERSION}/topics"
  end
end
