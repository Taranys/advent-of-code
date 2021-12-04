# frozen_string_literal: true

module AdventOfCode
  # Day 3
  class Day4
    def self.parse(input)
      lines = input.map(&:strip).reject(&:empty?)

      numbers = lines.shift.split(",").map(&:to_i)
      boards = lines.each_slice(5).to_a.map { |chunks| Board.new(chunks) }

      [numbers, boards]
    end
  end

  class Board
    def initialize(chunks)
      @data = chunks.map { |line| line.split.map { |value| { value: value.to_i, marked: false } } }
    end

    def mark(value)
      @data.each_with_index do |line, row_index|
        line.each_with_index do |a, column_index|
          if a[:value] == value
            @data[row_index][column_index][:marked] = true
          end
        end
      end
    end

    def bingo?
      return true if @data.any? { |line| line.all? { |a| a[:marked] } }

      false
    end

    def result(number)
      @data.sum { |line| line.sum { |a| a[:marked] ? 0 : a[:value] } } * number
    end
  end
end
