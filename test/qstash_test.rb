# frozen_string_literal: true

require "test_helper"

describe QStash do
  subject { QStash }

  it { assert_respond_to subject, :configuration }
  it { assert_respond_to subject, :config }
end
