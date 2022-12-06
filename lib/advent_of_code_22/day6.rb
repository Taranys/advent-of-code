# frozen_string_literal: true

module AdventOfCode22
  module Day6
    class Parser
      def self.distinct_chars_index(input, consecutive = 4)
        input.chars.each_with_index do |_, index|
          return index+consecutive if input[index..index+consecutive-1].chars.uniq.size == consecutive
        end
      end
    end
  end
end
