# frozen_string_literal: true

require "matrix"

module AdventOfCode22
  module Day14
    PRINT = {
      air: " ",
      rock: "#",
      sand: "o",
      starting_point: "+"
    }.freeze

    class Parser
      def self.cave(input, with_floor: false)
        values = input.map { |line| line.split(" -> ").map { |block| block.split(",").map(&:to_i) } }
        height = values.map { |row| row.map { |v| v[1] } }.flatten.max
        m = Matrix.build(500, 1000) do |r|
          next :rock if with_floor && r == height + 2

          :air
        end

        values.each do |line|
          (line.size - 1).times do |i|
            col1, row1 = line[i]
            col2, row2 = line[i + 1]

            col_range = [col1, col2].sort
            row_range = [row1, row2].sort

            (col_range[0]..col_range[1]).each { |col| m[row1, col] = :rock } if col1 != col2
            (row_range[0]..row_range[1]).each { |row| m[row, col1] = :rock } if row1 != row2
          end
        end

        Cave.new(m)
      end
    end

    class Cave
      def initialize(matrix)
        @matrix = matrix
        @falling_point = [0, 500]
      end

      def drop_sand
        row, col = @falling_point
        return false if @matrix[row, col] == :sand

        until stuck(row, col)
          if down(row, col) == :air
            row += 1
          elsif down_left(row, col) == :air
            row += 1
            col -= 1
          elsif down_right(row, col) == :air
            row += 1
            col += 1
          end
          return false if row >= 400
        end

        @matrix[row, col] = :sand
        true
      end

      def stuck(row, col)
        down_left(row, col) != :air && down(row, col) != :air && down_right(row, col) != :air
      end

      def down_left(row, col)
        @matrix[row + 1, col - 1]
      end

      def down(row, col)
        @matrix[row + 1, col]
      end

      def down_right(row, col)
        @matrix[row + 1, col + 1]
      end

      def print
        File.open("./log.txt", "w") do |f|
          @matrix.row_vectors.each do |line|
            f.write "#{line.to_a.map { |v| PRINT[v] }.join("")}\n"
          end
        end
      end
    end
  end
end
