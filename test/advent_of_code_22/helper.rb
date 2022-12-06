# frozen_string_literal: true

module AdventOfCode22
  class Helper
    def self.load_input(day)
      load_input_raw(day).map(&:strip).reject(&:empty?)
    end

    def self.load_input_raw(day)
      File.open("./test/advent_of_code_22/day#{day}/input.txt").readlines
    end

    def self.load_raw(day)
      File.open("./test/advent_of_code_22/day#{day}/input.txt").read
    end
  end
end
