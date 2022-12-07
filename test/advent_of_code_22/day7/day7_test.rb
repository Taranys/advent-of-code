# frozen_string_literal: true

require "minitest/autorun"

require_relative "../helper"
require_relative "../../../lib/advent_of_code_22/day7"

module AdventOfCode22
  module Day7
    class Test < Minitest::Test
      EXAMPLE = %(
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
).split("\n").map(&:strip).reject(&:empty?)

      def test_example
        assert_equal 95437, Parser.root(EXAMPLE).all_directories.map(&:size).reject { |size| size > 100000 }.sum
      end

      def test_first_star
        input = AdventOfCode22::Helper.load_input(7)
        p Parser.root(input).all_directories.map { |dir| "#{dir.name} #{dir.size}" }
        assert_equal 1513699, Parser.root(input).all_directories.map(&:size).reject { |size| size > 100000 }.sum
      end

      def test_second_example
        file_system = Parser.root(EXAMPLE)
        current_available_space = 70000000 - file_system.size
        needed_space = 30000000 - current_available_space

        assert_equal 24933642, file_system.all_directories.map(&:size).sort.reject { |size| size < needed_space }.first
      end

      def test_second_star
        input = AdventOfCode22::Helper.load_input(7)
        file_system = Parser.root(input)
        current_available_space = 70000000 - file_system.size
        needed_space = 30000000 - current_available_space

        assert_equal 7991939, file_system.all_directories.map(&:size).sort.reject { |size| size < needed_space }.first
      end
    end
  end
end
