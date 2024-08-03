# QStash

[![ci](https://github.com/dvmonroe/qstash-ruby/actions/workflows/ci.yml/badge.svg)](https://github.com/dvmonroe/qstash-ruby/actions/workflows/ci.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/f3219443a8f5fbecca77/maintainability)](https://codeclimate.com/github/dvmonroe/qstash-ruby/maintainability)

A Ruby client for the [QStash](https://upstash.com/qstash) service from Upstash.

QStash is an HTTP-based messaging and scheduling solution, designed for serverless and edge computing environments, guaranteeing at-least-once delivery.

If you're coming from a Rails background, you'll be familiar with ActiveJob, Sidekiq, and/or DelayedJob for background job processing. QStash can run background jobs which may/may not be a use case if you're using Ruby in a serverless environment but it's also much more than that. It can:

- Schedule messages to be delivered at a later time.
- Serve as a FIFO message queue.
- Serve as a push based fanout exchange (think RabbitMQ).

## Contents

- [QStash](#qstash)
  - [Contents](#contents)
  - [Getting Started](#getting-started)
  - [Messages](#messages)
  - [Events](#events)
  - [Signing Keys](#signing-keys)
  - [Dead Letter Queue](#dead-letter-queue)
  - [URL Groups](#url-groups)
  - [Development](#development)
  - [Contributing](#contributing)
  - [License](#license)


## Getting Started

Add this line to your application's Gemfile:

```ruby
gem 'qstash'
```

Setup your thread safe configuration:

```ruby
QStash.configure do |q|
  q.token = "your-qstash-token"
  q.url = "https://qstash.upstash.io"
end
```

or you can set the following ENV variables at runtime:

```bash
QSTASH_TOKEN=your-qstash-token
QSTASH_URL=https://qstash.upstash.io
```

## Messages

#### Publish
To [publish a message](https://upstash.com/docs/qstash/api/publish) to a queue:

```ruby
QStash::Message.publish(destination: "https://example.com/api/message-receiver", body: "Hello, World!")
```

From Upstash's docs:

> Destination can either be a topic name or id that you configured in the Upstash console, a valid url where the message gets sent to, or a valid QStash API name like api/llm. If the destination is a URL, make sure the URL is prefixed with a valid protocol (http:// or https://)

You can also pass in headers. We help format Upstash's headers for you if you pass them in:

```
- "Upstash-Method",
- "Upstash-Timeout",
- "Upstash-Retries",
- "Upstash-Callback",
- "Upstash-Failure-Callback",
- "Upstash-Forward-*
- "Upstash-Delay",
- "Upstash-Not-Before",
- "Upstash-Deduplication-Id",
- "Upstash-Content-Based-Deduplication"
```

```ruby
QStash::Message.publish(
  destination: "https://example.com/api/message-receiver",
  body: "Hello, World!",
  headers: { upstash_retries: 2 }
)
```

#### Enqueue

To [enqueue a message](https://upstash.com/docs/qstash/api/enqueue) to a queue:

```ruby
QStash::Message.enqueue(
  queue_name: "my-queue",
  destination: "https://example.com/api/message-receiver",
  body: "Hello, World!"
)
```

#### Batch

To [batch publish messages](https://upstash.com/docs/qstash/api/messages/batch):

```ruby
QStash::Message.batch_publish(messages: [
  {
    destination: "https://example.com/api/message-receiver",
    body: "Hello, World!"
  },
  {
    destination: "https://example.com/api/message-receiver",
    body: "Hello, World Again!",
    headers: { upstash_retries: 2 }
  }
])
```

#### Get

To [get a message](https://upstash.com/docs/qstash/api/messages/get) from a queue:

```ruby
QStash::Message.get("1234") # 1234 is the message id
```

#### Cancel

To [cancel a message](https://upstash.com/docs/qstash/api/messages/cancel) from a queue:

```ruby
QStash::Message.cancel("1234") # 1234 is the message id
```

#### Bulk Cancel

To [bulk cancel messages](https://upstash.com/docs/qstash/api/messages/bulk-cancel) from a queue:

```ruby
QStash::Message.cancel(["1234", "5678"])
```

## Events

#### List

To [list all events](https://upstash.com/docs/qstash/api/events/list):

```ruby
QStash::Event.list
```

You can pass in any filters available from the [Upstash docs](https://upstash.com/docs/qstash/api/events/list).

```ruby
QStash::Event.list(filters: {
  queueName: "my-queue",
  fromDate: Time.now - 1.day,
  toDate: Time.now
})
```

## Signing Keys

#### Get

To get your current [signing keys](https://upstash.com/docs/qstash/api/signingKeys/get):

```ruby
QStash::SigningKeys.get
```

#### Rotate

To [rotate signing keys](https://upstash.com/docs/qstash/api/signingKeys/rotate):

```ruby
QStash::SigningKeys.rotate
```

## Dead Letter Queue

#### Get

To [get dead letter messages](https://upstash.com/docs/qstash/api/dlq/getMessage):

```ruby
QStash::DLQ.get("1234") # 1234 is the dlq id of the message
```

#### List

To [list dead letter messages](https://upstash.com/docs/qstash/api/dlq/listMessages):

```ruby
QStash::DLQ.list
```

To [list dead letter messages with filters](https://upstash.com/docs/qstash/api/dlq/listMessages):

```ruby
QStash::DLQ.list(filters: {
  queueName: "my-queue", 
  fromDate: Time.now - 1.day, 
  toDate: Time.now 
})
```

#### Delete

To [delete dead letter messages](https://upstash.com/docs/qstash/api/dlq/deleteMessage):

```ruby
QStash::DLQ.delete("1234") # 1234 is the dlq id of the message
```

#### Delete Multiple

To [delete multiple dead letter messages](https://upstash.com/docs/qstash/api/dlq/deleteMessages):

```ruby
QStash::DLQ.delete(["1234", "5678"])
```

## URL Groups

#### List

To [list all url groups](https://upstash.com/docs/qstash/api/url-groups/list):

```ruby
QStash::URLGroup.list
```

#### Add Endpoints

To [add endpoints to a url group](https://upstash.com/docs/qstash/api/url-groups/add-endpoint):

```ruby
QStash::URLGroup.add_endpoints(url_group_name: "my-url-group", endpoints: [{url: "https://example.com/api/message-receiver"}])
```

**Note that this will create the url group if it doesn't already exist.**

#### Delete Endpoints

To [delete endpoints from a url group](https://upstash.com/docs/qstash/api/url-groups/remove-endpoint):

```ruby
QStash::URLGroup.delete_endpoints(url_group_name: "my-url-group", endpoints: [{url: "https://example.com/api/message-receiver"}])
```

#### Delete

To [delete a url group](https://upstash.com/docs/qstash/api/url-groups/remove):

```ruby
QStash::URLGroup.delete("my-url-group")
```

#### Get

To [get a url group](https://upstash.com/docs/qstash/api/url-groups/get):

```ruby
QStash::URLGroup.get("my-url-group")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

### Testing across all supported versions:

To run tests across all gem supported ruby versions (requires Docker):
```sh
bin/dev-test
```
To run lint across all gem supported ruby versions (requires Docker):
```sh
bin/dev-lint
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dvmonroe/qstash-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
