# frozen_string_literal: true

module AdventOfCode
  class Helper
    def self.load_input(day)
      self.load_input_raw(day).map(&:strip).reject(&:empty?)
    end

    def self.load_input_raw(day)
      File.open("./test/advent_of_code_22/day#{day}/input.txt").readlines
    end
  end
end
