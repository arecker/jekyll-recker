# frozen_string_literal: true

require 'logger'

module JekyllRecker
  module Mixins
    # Introspection
    #
    # Adds functions which let the class see things about itself.
    module Introspection
      def self.included(base)
        base.extend(self)
      end

      # Get the class instance
      def class_name
        self.class.name.split('::').last
      end

      # Get a list of all classes which inherit from this class
      def descendants
        ObjectSpace.each_object(Class).select { |klass| klass < self }
      end
    end

    # Logging
    module Logging
      def self.included(base)
        base.extend(self)
      end

      def logger
        @logger ||= Logger.new(
          STDOUT,
          formatter: proc { |_severity, _datetime, _progname, msg| "jekyll-recker: #{msg}\n" }
        )
      end
    end
  end
end
