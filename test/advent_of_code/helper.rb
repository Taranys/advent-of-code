# frozen_string_literal: true

module AdventOfCode
  class Helper
    def self.load_input(day)
      File.open("./test/advent_of_code/day#{day}/input.txt").readlines.map(&:strip).reject(&:empty?)
    end
  end
end
