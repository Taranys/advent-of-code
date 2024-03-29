# frozen_string_literal: true

module AdventOfCode22
  module Day5
    class Parser
      def self.ship(input)
        lines = ship_input(input)

        ship = Ship.new
        lines
          .map { |line| parse_ship_line(line) }
          .reverse
          .each do |line|
            line.each_with_index { |value, index| ship.add_crate(index, value) if value != " " }
          end

        ship
      end

      def self.moves(input)
        moves_input = input.split("\n\n")[1]
        lines = moves_input.split("\n").map(&:strip).reject(&:empty?)

        lines
          .map { |line| /move (.+) from (.) to (.)/.match(line) }
          .map { |match| Move.new(match[1], match[2], match[3]) }
      end

      def self.ship_input(input)
        ship_input = input.split("\n\n").first
        lines = ship_input.split("\n").reject(&:empty?)
        lines.pop
        lines
      end

      def self.parse_ship_line(line)
        r = []
        line.chars.each_slice(4) do |v|
          r << v[1]
        end
        r
      end
    end

    class Ship
      attr_reader :crates

      def initialize
        @crates = []
      end

      def add_crate(index, value)
        @crates[index] = [] if @crates[index].nil?
        @crates[index] << value
      end

      def top_crates
        @crates.map(&:last).join
      end
    end

    class Move
      attr_accessor :count, :from, :to

      def initialize(count, from_index, to_index)
        @count = count.to_i
        @from = from_index.to_i
        @to = to_index.to_i
      end
    end

    class Crane
      def initialize(ship)
        @ship = ship
      end

      def apply(move)
        move.count.times do
          crate = @ship.crates[move.from - 1].pop
          @ship.crates[move.to - 1] << crate
        end
      end
    end

    class Crane9001
      def initialize(ship)
        @ship = ship
      end

      def apply(move)
        crates = take_crates(move)
        @ship.crates[move.to - 1] = @ship.crates[move.to - 1].concat(crates)
      end

      private

      def take_crates(move)
        buffer = []
        move.count.times do
          buffer << @ship.crates[move.from - 1].pop
        end
        buffer.reverse
      end
    end
  end
end
