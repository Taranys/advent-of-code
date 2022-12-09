# frozen_string_literal: true

require "matrix"

module AdventOfCode22
  module Day9
    DIRECTION = {
      R: :right,
      U: :up,
      L: :left,
      D: :down
    }.freeze
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
        @rope = rope_length.times.map { Position.new(500, 500) }
        mark_last_tail_position
      end

      def apply(move)
        move.step.times do
          @rope[0] = move(@rope.first, move.direction)
          (@rope.size - 1).times do |i|
            @rope[i + 1] = follow(@rope[i], @rope[i + 1])
          end
          mark_last_tail_position
        end
      end

      def visited
        @dim.to_a
      end

      private

      def move(head, direction)
        case direction
        when :up
          Position.new(head.row + 1, head.col)
        when :right
          Position.new(head.row, head.col + 1)
        when :down
          Position.new(head.row - 1, head.col)
        when :left
          Position.new(head.row, head.col - 1)
        end
      end

      def follow(head, tail)
        row = next_row(head, tail)
        col = next_col(head, tail)
        new_pos = Position.new(row, col)
        force_diagonal(head, tail, new_pos)
      end

      def next_row(head, tail)
        vert_diff = head.row - tail.row
        row = tail.row
        row = head.row - 1 if vert_diff > 1
        row = head.row + 1 if vert_diff < -1
        row
      end

      def next_col(head, tail)
        horiz_diff = head.col - tail.col
        col = tail.col
        col = head.col - 1 if horiz_diff > 1
        col = head.col + 1 if horiz_diff < -1
        col
      end

      def force_diagonal(head, tail, new_pos)
        return Position.new(new_pos.row, head.col) if force_horiz_diagonal?(head, tail, new_pos)
        return Position.new(head.row, new_pos.col) if force_vert_diagonal?(head, tail, new_pos)

        new_pos
      end

      def force_horiz_diagonal?(head, tail, new_pos)
        horiz_diff = head.col - tail.col
        tail.row != new_pos.row && horiz_diff.abs == 1
      end

      def force_vert_diagonal?(head, tail, new_pos)
        vert_diff = head.row - tail.row
        tail.col != new_pos.col && vert_diff.abs == 1
      end

      def mark_last_tail_position
        last = @rope.last
        p last
        @dim[last.row, last.col] = 1
      end
    end
  end
end
