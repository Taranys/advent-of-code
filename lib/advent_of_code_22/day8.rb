# frozen_string_literal: true
require 'matrix'

module AdventOfCode22
  module Day8
    class Parser
      def self.trees(input)
        forest = Forest.new(input.size)

        input.each_with_index do |line, row|
          line.chars.map(&:to_i).each_with_index do |height, col|
            forest.add_tree(row, col, height)
          end
        end

        forest
      end
    end

    class Forest
      def initialize(size)
        @trees = Matrix.zero(size)
      end

      def add_tree(row, col, height)
        @trees[row, col] = height
      end

      def visible_trees
        @visibles = Matrix.zero(@trees.column_count)
        compute_visible_trees
        @visibles.to_a.flatten.count { |v| v == true }
      end

      def scenic_score
        @scenic_scores = Matrix.zero(@trees.column_count)
        @scenic_scores.each_with_index do |_, i, j|
          @scenic_scores[i, j] = compute_scenic_score(i, j)
        end
        @scenic_scores
      end

      private

      def compute_scenic_score(row, col)
        height = @trees[row, col]

        return 0 if border?(row, col)

        [up(row, col).reverse, down(row, col), left(row, col).reverse, right(row, col)]
          .map do |values|
            values.slice_when { |h| h >= height }.to_a.first&.size || 0
          end
          .reduce(:*)
      end

      def compute_visible_trees
        @trees.each_with_index do |_, row, col|
          if border?(row, col)
            @visibles[row, col] = true
          else
            @visibles[row, col] = check_visibility(row, col)
          end
        end
      end

      def check_visibility(row, col)
        tree_height = @trees[row, col]

        left(row, col).max < tree_height ||
          right(row, col).max < tree_height ||
          up(row, col).max < tree_height ||
          down(row, col).max < tree_height
      end

      def left(row, col)
        @trees.row(row)[0..col-1]
      end

      def right(row, col)
        @trees.row(row)[(col+1)..@trees.column_count-1]
      end

      def up(row, col)
        @trees.column(col)[0..(row-1)]
      end

      def down(row, col)
        @trees.column(col)[(row+1)..@trees.row_count-1]
      end

      def border?(row, col)
        forest_size = @trees.column_count - 1
        (row == 0 || row == forest_size || col == 0 || col == forest_size)
      end
    end
  end
end
