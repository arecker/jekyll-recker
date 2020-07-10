# frozen_string_literal: true

require 'open3'

module JekyllRecker
  # Shell
  module Shell
    # ShellCommandFailed
    class ShellCommandFailed < JekyllRecker::Error; end

    def self.run(cmd)
      out, err, status = Open3.capture3(cmd)
      return out if status.success?

      msg = <<~ERROR
        the command \`#{cmd}\` failed!
        --- exit
        #{status}
        --- stdout
        #{out}
        --- stderr
        #{err}
      ERROR

      raise ShellCommandFailed, msg
    end
  end
end
