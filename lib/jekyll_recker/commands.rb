# frozen_string_literal: true

module JekyllRecker
  # Commands
  module Commands
    # Share Command
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
        site = Jekyll::Site.new(configuration_from_options(options))
        site.reset
        site.read
        Social.action(site, args, options)
      rescue StandardError => e
        logger.error e.message
        exit 1
      end
    end

    # Today Command
    class Today < Jekyll::Command
      include Mixins::Logging

      def self.init_with_program(prog)
        prog.command(:today) do |c|
          c.syntax 'today'
          c.description 'Open today\'s entry'
          c.option 'dry', '-d', '--dry', 'perform dry run'
          c.action { |args, opts| action(args, opts) }
        end
      end

      def self.action(args, options)
        filename = Time.now.strftime("%Y-%m-%d-%Y-%m-%d.html.md")
        logger.info "#{filename}"
        # site = Jekyll::Site.new(configuration_from_options(options))
        # site.reset
        # site.read
        # Social.action(site, args, options)
      rescue StandardError => e
        logger.error e.message
        exit 1
      end
    end
  end
end
