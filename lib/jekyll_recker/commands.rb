# frozen_string_literal: true

module JekyllRecker
  # Commands
  module Commands
    # Share
    class Share < Jekyll::Command
      include Mixins::Logging

      def self.init_with_program(prog)
        prog.command(:share) do |c|
          c.syntax 'share'
          c.description 'Share latest post with each configured backend'
          c.option 'dry', '-d', '--dry', 'perform dry run'
          c.action { |args, opts| action(args, opts) }
        end
      end

      def self.action(args, options)
        JekyllRecker::Social.action(args, options)
      rescue ::JekyllRecker::Error => e
        logger.error e.message
        exit 1
      end
    end
  end
end
