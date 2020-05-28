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
          logger.info "sharing with args=#{args} options=#{options}"
          if args.empty? || args.include?('slack')
            Recker::Slack.share(dry: options['dry'])
          elsif args.empty? || args.include?('twitter')
            Recker::Twitter.share(dry: options['dry'])
          end
        rescue ReckerError => e
          logger.abort_with e.message
        end
      end
    end
  end
end
