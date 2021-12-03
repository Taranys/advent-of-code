# frozen_string_literal: true

module AdventOfCode
  # Day 3
  class Day3
    def self.power_consumption(input)
      gamma = input.transpose
         .map { |values| values.count(0) }
         .map { |number_of_0| number_of_0 >= (input.count / 2) ? 0 : 1 }
         .join

      [gamma.to_i(2), gamma.chars.map{ |v| v == '0' ? '1' : '0' }.join.to_i(2)]
    end

    def self.bit_criteria(input, position)
      number_of_0 = input.count { |value| value[position] == '0' }
      return 1 if number_of_0 == (input.count / 2)
      number_of_0 >= (input.count / 2) ? 0 : 1
    end

    def self.oxygen_generator_support(input)
      result = ''

      for i in 0..input[0].size-1
        p input
        bc = bit_criteria(input, i).to_s
        result += bc
        input = input.select{ |value| value[i] == bc }
      end

      result.to_i(2)
    end

    def self.c02(input)
      result = ''

      for i in 0..input[0].size-1
        p input
        return input[0].to_i(2) if input.size == 1
        bc = (bit_criteria(input, i) == 0 ? 1 : 0).to_s
        result += bc
        input = input.select{ |value| value[i] == bc }
      end

      result.to_i(2)
    end
  end
end
