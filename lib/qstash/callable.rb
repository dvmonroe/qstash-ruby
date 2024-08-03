# frozen_string_literal: true

module QStash
  module Callable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def call(*args, **)
        if args.empty?
          new(**).call
        else
          new(*args, **).call
        end
      end
    end
  end
end
