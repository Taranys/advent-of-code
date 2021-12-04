# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code/day4"

module AdventOfCode
  class Day4Test < Minitest::Test
    def test_example
      input = %[
      7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
].split("\n")

      input2 = AdventOfCode::Helper.load_input(4)

      numbers, boards = Day4.parse(input2)

      winners = []
      numbers.each do |number|
        boards.each { |board| board.mark(number) }
        boards.each do |board|
          if board.bingo?
            winners << board.result(number)
            boards = boards.reject{ |b| b == board }
          end
        end
      end

      p winners.first
      p winners.last
    end
  end
end
