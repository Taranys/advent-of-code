# frozen_string_literal: true

module AdventOfCode
  # NavigationSystem
  class NavigationSystem
    PAIR_MATCHER = /(\[\])|(\(\))|(\{\})|(<>)/.freeze
    START_MATCHER = /(\[)|(\()|(\{)|(<)/.freeze

    TO_PAIR = { "{" => "}", "[" => "]", "(" => ")", "<" => ">" }.freeze
    TO_VALUE = { ")" => 3, "]" => 57, "}" => 1197, ">" => 25_137 }.freeze

    def initialize(input)
      @data = input
    end

    def illegal_characters
      @data.map { |line| find_illegal_character(line).first }.compact
    end

    def auto_complete
      @data.map { |line| find_auto_complete(line) }.compact
    end

    private

    def find_auto_complete(line)
      line = clean_data(PAIR_MATCHER, line)

      line.chars.reverse.map do |c|
        return nil unless TO_PAIR.include?(c)

        TO_PAIR[c]
      end
          .join
    end

    def find_illegal_character(line)
      line = clean_data(PAIR_MATCHER, line)
      line = clean_data(START_MATCHER, line)
      line.chars
    end

    def clean_data(regexp, line)
      line = line.gsub(regexp, "") while regexp.match?(line)
      line
    end
  end
end
