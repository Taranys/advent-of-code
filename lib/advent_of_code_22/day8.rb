# frozen_string_literal: true
require 'matrix'

module AdventOfCode22
  module Day8
    class Parser
      def self.trees(input)
        forest = Forest.new

        input.each do |line|
          # tree_line = line.chars.map(&:to_i).map { |height| Tree.new(height) }
          tree_line = line.chars.map(&:to_i)
          forest.add_trees(tree_line)
        end

        forest
      end
    end

    class Forest
      def initialize
        @trees = []
        @visibles = []
      end

      def add_trees(tree_line)
        @trees << tree_line
        @visibles << tree_line.map { |_| nil }
      end

      def visible_trees
        compute_visible_trees
        @visibles.flatten.count { |v| v == true }
      end

      private

      def compute_visible_trees
        set_edge_visible
        @trees.each_with_index do |tree_line, i|
          tree_line.each_with_index do |_, j|
            @visibles[i][j] = check_visibility(i, j)
          end
        end
      end

      def set_edge_visible
        @trees.size.times do |i|
          @visibles[0][i] = true
          @visibles[i][0] = true
          @visibles[@trees.size - 1][i] = true
          @visibles[i][@trees.size - 1] = true
        end
      end

      def check_visibility(i, j)
        return true if @visibles[i][j]

        tree_height = @trees[i][j]
        forest_size = @trees.size - 1

        return true if @trees[i][0..(j-1)].max < tree_height
        return true if @trees[i][(j+1)..forest_size].max < tree_height

        m = Matrix.rows(@trees)
        return true if m.column(j)[0..(i-1)].max < tree_height
        return true if m.column(j)[(i+1)..forest_size].max < tree_height

        false
      end
    end

    class Tree
      attr_reader :height

      def initialize(height)
        @height = height
      end
    end
  end
end
