# frozen_string_literal: true

require "matrix"

module AdventOfCode22
  module Day9
    DIRECTION = {
      R: :right,
      U: :up,
      L: :left,
      D: :down
    }
    Move = Struct.new(:direction, :step)
    Position = Struct.new(:row, :col)

    class Parser
      def self.rope_movements(input)
        input.map do |line|
          direction, steps = line.split(" ")
          Move.new(DIRECTION[direction.to_sym], steps.to_i)
        end
      end
    end

    class RopeDimension
      def initialize(rope_length = 2)
        @dim = Matrix.zero(1000)
        @rope = rope_length.times.map { Position.new(500,500) }
        mark_last_tail_position
      end

      def apply(move)
        move.step.times do
          @rope[0] = move_head(move.direction)
          (@rope.size-1).times do |i|
            @rope[i+1] = follow(@rope[i], @rope[i+1])
          end
          mark_last_tail_position
        end
      end

      def visited
        @dim.to_a
      end

      private

      def follow(head, tail)
        vert_diff = head.row - tail.row
        horiz_diff = head.col - tail.col

        p ['---', vert_diff, horiz_diff] if vert_diff.abs > 1 && horiz_diff.abs > 1

        row = tail.row
        row = head.row-1 if vert_diff > 1
        row = head.row+1 if vert_diff < -1

        col = tail.col
        col = head.col-1 if horiz_diff > 1
        col = head.col+1 if horiz_diff < -1

        # force diag
        if tail.row != row && horiz_diff.abs == 1
          col = head.col
        elsif tail.col != col && vert_diff.abs == 1
          row = head.row
        end

        p [head, tail] if vert_diff.abs > 1 && horiz_diff.abs > 1
        p [row, col] if vert_diff.abs > 1 && horiz_diff.abs > 1

        Position.new(row, col)
      end

      def mark_last_tail_position
        last = @rope.last
        @dim[last.row, last.col] = 1
      end

      def move_head(direction)
        head = @rope.first
        case direction
        when :up
          Position.new(head.row+1, head.col)
        when :right
          Position.new(head.row, head.col+1)
        when :down
          Position.new(head.row-1, head.col)
        when :left
          Position.new(head.row, head.col-1)
        else
          raise "Error #{direction}"
        end
      end
    end
  end
end
