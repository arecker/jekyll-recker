# frozen_string_literal: true

module Jekyll
  module Recker
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
          args += %w[slack twitter] if args.empty?
          Recker::Slack.share(dry: options['dry']) if args.include?('slack')
          Recker::Twitter.share(dry: options['dry']) if args.include?('twitter')
        rescue ReckerError => e
          logger.error e.message
          exit 1
        end
      end
    end
  end
end
