# frozen_string_literal: true

module AdventOfCode
  # ThermalCamera
  class ThermalCamera
    def initialize(input)
      @dots = []
      @folds = []

      input.each do |line|
        if line.start_with? "fold"
          @folds << line.gsub("fold along ", "").split("=")
        else
          @dots << line.split(",").map(&:to_i)
        end
      end
    end

    def visible_dots_after_one_fold
      right = @dots.map { |val| val[0] }.max + 1
      down = @dots.map { |val| val[1] }.max + 1

      map = Array.new(down) { Array.new(right, false) }
      @dots.each { |dot| map[dot[1]][dot[0]] = true }

      fold(map, @folds.first)

      map = map.reject { |line| line.none? { |dot| dot == true } }

      map.map { |line| line.map { |dot| dot ? 1 : 0 }.sum }.sum
    end

    def display_folded_dots
      right = @dots.map { |val| val[0] }.max + 1
      down = @dots.map { |val| val[1] }.max + 1

      map = Array.new(down) { Array.new(right, false) }
      @dots.each { |dot| map[dot[1]][dot[0]] = true }

      @folds.each { |fold_position| fold(map, fold_position) }

      map = map.reject { |line| line.none? { |dot| dot == true } }

      map.map { |line| line.map { |dot| dot ? "#" : "." }.join }.join("\n")
    end

    private

    def fold(map, fold_line)
      type, index = fold_line[0], fold_line[1].to_i

      map.each_with_index do |line, row|
        line.each_with_index do |dot, column|
          if type == "y" && row > index && dot
            map[row][column] = false
            map[index - (row - index)][column] = true
          end

          if type == "x" && column > index && dot
            map[row][column] = false
            map[row][index - (column - index)] = true
          end
        end
      end

      map
    end
  end
end
