# frozen_string_literal: true

require 'koala'

module Jekyll
  module Recker
    # Facebook Client
    class Facebook
      include Mixins::Logging

      def self.share(dry: false)
        client = new(dry: dry)
        logger.info 'discovering credentials'
        client.discover_credentials!
        logger.info "sharing #{client.latest.data['title']}"
        client.post_latest!
      end

      def initialize(dry: false)
        @dry = dry
      end

      def discover_credentials!
        @creds = extract_from_env || extract_from_config
        raise ReckerError, 'cannot find facebook credentials!' if @creds.nil?

        set_credentials!
      end

      def post_latest!
        if @dry
          logger.info('posting in dry mode, printing message')
          logger.info("BEGIN POST\n#{post_body.strip}\nEND POST")
        else
          @graph.put_connections("me", "feed", message: "I am writing on my wall!")
        end
      end

      def latest
        Configuration.latest_post
      end

      private

      def post_body
        url = File.join Configuration.jekyll['url'], latest.url
        <<~POST
          #{latest.data['date'].strftime('%A, %B %-d %Y')}
          #{latest.data['title']}
          #{url}
        POST
      end

      def set_credentials!
        Koala.configure do |config|
          config.access_token = @creds['access_token']
          # config.app_access_token = @creds['app_access_token']
          config.app_id = @creds['app_id']
          config.app_secret = @creds['app_secret']
        end
        @client = Koala::Facebook::API.new(@creds['access_token'])
      end

      def extract_from_env
        values = cred_fieldnames.map { |k| ENV["FACEBOOK_#{k.upcase}"] }

        return nil if values.any? { |v| v.nil? || v.empty? }

        Hash[cred_fieldnames.zip(values)]
      end

      def extract_from_config
        values = cred_fieldnames.map do |k|
          cmd = Configuration.facebook.fetch("#{k}_cmd", '').strip
          if cmd.empty?
            nil
          else
            Recker.shell(Configuration.facebook["#{k}_cmd"]).strip
          end
        end

        return nil if values.any? { |v| v.nil? || v.empty? }

        Hash[cred_fieldnames.zip(values)]
      end

      def cred_fieldnames
        # app_access_token
        %w[
          access_token
          app_id
          app_secret
        ]
      end
    end
  end
end
