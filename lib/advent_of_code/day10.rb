# frozen_string_literal: true

module AdventOfCode
  class NavigationSystem
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
      while line.include?("[]") || line.include?("{}") || line.include?("()") || line.include?("<>")
        line = line.sub("[]", "")
        line = line.sub("()", "")
        line = line.sub("{}", "")
        line = line.sub("<>", "")
      end

      # p [line.chars, test]

      line.chars.reverse.map do |c|
        case c
        when "("
          ")"
        when "{"
          "}"
        when "["
        "]"
        when "<"
        ">"
        else
          return nil
        end
      end
          .join
    end

    def find_illegal_character(line)
      while line.include?("[]") || line.include?("{}") || line.include?("()") || line.include?("<>")
        line = line.sub("[]", "")
        line = line.sub("()", "")
        line = line.sub("{}", "")
        line = line.sub("<>", "")
      end

      while line.include?("[") || line.include?("{") || line.include?("(") || line.include?("<")
        line = line.sub("[", "")
        line = line.sub("(", "")
        line = line.sub("{", "")
        line = line.sub("<", "")
      end

      line.chars
    end

    def self.char_to_i(char)
      case char
      when ")"
        3
      when "]"
        57
      when "}"
        1197
      when ">"
        25137
      else
        raise StandardError("Invalid character #{char}")
      end
    end
  end
end
