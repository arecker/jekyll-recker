# frozen_string_literal: true

module Jekyll
  module Recker
    # Filters
    module Filters
      # Converts a date object to standard Uhh Yeah Dude format.
      def uyd_date(date)
        date.strftime('%A, %B %d %Y')
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::Recker::Filters)
