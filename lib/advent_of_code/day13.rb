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

      @map = create_map
    end

    def visible_dots_after_one_fold
      fold(@folds.first)
      remove_empty_lines
      count_dots
    end

    def display_folded_dots
      @folds.each { |fold_position| fold(fold_position) }
      remove_empty_lines
      map_to_s
    end

    private

    def create_map
      right = @dots.map { |val| val[0] }.max + 1
      down = @dots.map { |val| val[1] }.max + 1

      map = Array.new(down) { Array.new(right, false) }
      @dots.each { |dot| map[dot[1]][dot[0]] = true }
      map
    end

    def remove_empty_lines
      @map.reject! { |line| line.none? { |dot| dot == true } }
    end

    def count_dots
      @map.map { |line| line.map { |dot| dot ? 1 : 0 }.sum }.sum
    end

    def map_to_s
      @map.map { |line| line.map { |dot| dot ? "#" : " " }.join.rstrip }.join("\n")
    end

    def fold(fold_line)
      type = fold_line[0]
      index = fold_line[1].to_i

      @map.each_with_index do |line, row|
        line.each_with_index do |_dot, column|
          swap_dot_vertically(index, row, column) if type == "y"
          swap_dot_horizontally(index, row, column) if type == "x"
        end
      end

      @map
    end

    def swap_dot_horizontally(index, row, column)
      return unless column > index && @map[row][column]

      @map[row][column] = false
      @map[row][index - (column - index)] = true
    end

    def swap_dot_vertically(index, row, column)
      return unless row > index && @map[row][column]

      @map[row][column] = false
      @map[index - (row - index)][column] = true
    end
  end
end
