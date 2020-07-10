# frozen_string_literal: true

module JekyllRecker
  # Utils
  module Utils
    def self.array_to_and_list(array)
      case array.length
      when 0
        ''
      when 1
        array.first
      when 2
        "#{array.first} and #{array.last}"
      else
        array[0...-1].join(', ') + ", and #{array.last}"
      end
    end

    def self.and_list_to_array(str)
      str = str.gsub(' and ', ', ')
      str.split(',').map(&:strip).reject(&:empty?)
    end

    def self.prettify_number(number)
      number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    end

    def self.prettify_path(path, home = nil)
      home ||= File.expand_path('~/')
      path.sub(home, '~')
    end

    def self.to_word_list(str)
      str.split(' ')
    end
  end
end
