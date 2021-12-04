# frozen_string_literal: true

module AdventOfCode
  # Day 3
  class Day4
    def self.parse(input)
      lines = input.map(&:strip).reject(&:empty?)

      numbers = lines.shift.split(",").map(&:to_i)
      boards = lines.each_slice(5).to_a.map { |chunks| Board.new(chunks) }

      [numbers, Game.new(boards)]
    end
  end

  # A game
  class Game
    attr_reader :winners

    def initialize(boards)
      @boards = boards
      @winners = []
    end

    def play(number)
      @boards.each do |board|
        board.mark(number)
        if board.bingo?
          winners << board.result(number)
          @boards = @boards.reject { |b| b == board }
        end
      end
    end
  end

  # a board of bingo
  class Board
    def initialize(chunks)
      @data = chunks.map { |line| line.split.map { |value| { value: value.to_i, marked: false } } }
    end

    def mark(value)
      @data.each_with_index do |line, row_index|
        line.each_with_index do |a, column_index|
          @data[row_index][column_index][:marked] = true if a[:value] == value
        end
      end
    end

    def bingo?
      return true if bingo_on_line?
      return true if bingo_on_column?

      # diagonal are not used in the exercise

      false
    end

    def result(number)
      @data.sum { |line| line.sum { |a| a[:marked] ? 0 : a[:value] } } * number
    end

    private

    def bingo_on_line?
      @data.any? { |line| line.all? { |a| a[:marked] } }
    end

    def bingo_on_column?
      (0..4).each do |i|
        return true if @data.map { |line| line[i][:marked] }.all?(true)
      end
      false
    end
  end
end
