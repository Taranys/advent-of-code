# frozen_string_literal: true

module AdventOfCode
  class Probe
    def initialize(input)
      @position = [0, 0]
      x, y = input.gsub("target area: ", "").split(", ").map { |v| v.split("=")[1].split("..").map(&:to_i) }

      @target = { x: x, y: y }
    end

    def find_working_point
      x = 0
      sum_x = 0
      1000.times do |i|
        sum_x += i
        if sum_x > @target[:x][0] && sum_x < @target[:x][1]
          x = i
          break
        end
      end

      p [x, @target[:y][1] + x]
    end

    def touch_target(x, y)
      position = { x: 0, y: 0 }

      while position[:x] <= @target[:x][1] && position[:y] >= @target[:y][1]
        position[:x] += x
        position[:y] += y
        x -= 1 if x.positive?
        x += 1 if x.negative?
        y -= 1

        if position[:x] <= @target[:x][1] && position[:x] >= @target[:x][0] && position[:y] <= @target[:y][1] && position[:y] >= @target[:y][0]
          return true
        end
      end

      false
    end

    def max_y
      x, y = find_working_point

      max = y

      500.times do |i|
        500.times do |j|
          max = [max, y+j].max if touch_target(x + i, y + j)
        end
      end

      (max + 1).times.sum
    end
  end
end
