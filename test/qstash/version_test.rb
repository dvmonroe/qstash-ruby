# frozen_string_literal: true

require "test_helper"

describe QStash::VERSION do
  subject { QStash::VERSION }

  it { refute_nil subject }
end
