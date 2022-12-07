# frozen_string_literal: true

module AdventOfCode22
  module Day7
    class Parser
      def self.root(input)
        root = Dir.new(nil, '/')
        current = root

        input.each do |line|
          next if(line == '$ cd /')
          next if(line == '$ ls')

          if line == '$ cd ..'
            current = current.parent
            next
          end

          new_dir_matcher = /dir (.*)/.match(line)
          current.add_child(Dir.new(current, new_dir_matcher[1])) unless new_dir_matcher.nil?

          new_file_matcher = /(\d+) (.*)/.match(line)
          current.add_child(File.new(current, new_file_matcher[2], new_file_matcher[1].to_i)) unless new_file_matcher.nil?

          go_inside_matcher = /[$] cd (.*)/.match(line)
          current = current.child(go_inside_matcher[1]) unless go_inside_matcher.nil?
        end

        root
      end
    end

    class Dir
      attr_reader :parent, :name

      def initialize(parent, name)
        @parent = parent
        @name = name
        @children = []
      end

      def child(name)
        @children.find { |child| child.name == name }
      end

      def add_child(child)
        @children << child
      end

      def all_directories(entries = [])
        @children.each do |child|
          next if child.is_a? File
          child.all_directories entries
        end
        entries << self
        entries
      end

      def size
        @children.map(&:size).sum
      end
    end

    class File
      attr_reader :parent, :name, :size

      def initialize(parent, name, size)
        @parent = parent
        @name = name
        @size = size
      end
    end
  end
end
