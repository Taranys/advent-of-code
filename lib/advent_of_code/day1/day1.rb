
module AdventOfCode
  class Day1
    def self.simple_measure(input)
      count = 0

      input.each_index do |index|
        next if index == 0
        count = count + 1 if input[index-1].to_i < input[index].to_i
      end

      count
    end

    def self.complex_measure(input)
      count = 0

      input.each_index do |index|
        next if index < 3
        count = count + 1 if input[index-3..index-1].sum < input[index-2..index].sum
      end

      count
    end
  end
end
