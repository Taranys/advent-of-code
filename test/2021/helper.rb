# frozen_string_literal: true

module AdventOfCode
  class Helper
    def self.load_input(day)
      load_input_raw(day).map(&:strip).reject(&:empty?)
    end

    def self.load_input_raw(day)
      File.open("./test/2021/day#{day}/input.txt").readlines
    end
  end
end
