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
          if args.empty? || args.include?('slack')
            Recker::Slack.share(dry: options['dry'])
          elsif args.empty? || args.include?('twitter')
            Recker::Twitter.share(dry: options['dry'])
          # elsif args.empty? || args.include?('facebook')
          #   Recker::Facebook.share(dry: options['dry'])
          end
        rescue ReckerError => e
          logger.error e.message
          exit 1
        end
      end
    end
  end
end
