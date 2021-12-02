module AdventOfCode
  class Helper
    def self.loadInput(day)
      File.open("./test/advent_of_code/day#{day}/input.txt").readlines
    end
  end
end
