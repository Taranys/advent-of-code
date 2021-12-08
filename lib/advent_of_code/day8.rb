# frozen_string_literal: true

module AdventOfCode
  DIGITS = %w[abcefg cf acdeg acdfg bcdf abdfg abdefg acf abcdefg abcdfg].freeze
  EXPECTED = DIGITS.map { |dig| dig.chars.map { |c| (c.ord - "a".ord).to_s }.join }
  # Day 8
  class Day8
    def self.count1478(values)
      values.map { |value| count1478_for_one_line(value[0], value[1]) }.sum
    end

    def self.count1478_for_one_line(_signal_patterns, output_digits)
      output_digits.count do |digits|
        length = digits.length
        [2, 4, 3, 7].include?(length)
      end
    end

    def self.count_all(values)
      values.map { |line| find_output(line[0], line[1]) }.sum
    end

    def self.find_output(signal_patterns, output_digits)
      possibilities = %w[a b c d e f g].permutation

      valid_permutation = possibilities.filter { |pos| valid?(pos, signal_patterns) }.first

      valid_digit = output_digits.map { |output| EXPECTED.find_index(convert_output(valid_permutation, output)) }

      valid_digit.join.to_i
    end

    def self.valid?(pos, values)
      test = values.map { |v| convert_output(pos, v) }

      test.all? { |values| EXPECTED.include?(values) }
    end

    def self.convert_output(map, output)
      output.chars.map { |c| map.find_index(c) }.sort.join
    end
  end
end
