# frozen_string_literal: true

require 'logger'

module Jekyll
  module Recker
    module Mixins
      # Descendants
      module Descendants
        def self.included(base)
          base.extend(self)
        end

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
end
