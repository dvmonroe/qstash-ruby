# frozen_string_literal: true

module QStash
  module Endpoints
    # Messages
    ENQUEUE_ENDPOINT = "v2/enqueue"
    PUBLISH_ENDPOINT = "v2/publish"
    BATCH_ENDPOINT = "v2/batch"
    GET_ENDPOINT = "v2/messages"
    CANCEL_ENDPOINT = "v2/messages"
    BULK_CANCEL_ENDPOINT = "v2/messages"

    # Events
    LIST_EVENTS_ENDPOINT = "v2/events"

    # Signing Keys
    ROTATE_SIGNING_KEY_ENDPOINT = "v2/keys/rotate"
    SIGNING_KEYS_ENDPOINT = "v2/keys"

    # Dead Letter Queue
    DLQ_ENDPOINT = "v2/dlq"
  end
end
