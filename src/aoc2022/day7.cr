require "./solver"

module AoC2022
  class Day7 < Solver
    class File
      getter name : String
      getter size : Int64

      def initialize(@name : String, @size : Int64)
      end
    end

    class Dir
      getter name : String
      getter dirs : Array(Dir)
      getter files : Array(File)
      @size : Int64?

      def initialize(@name : String, @parent : Dir? = nil)
        @files = Array(File).new
        @dirs = Array(Dir).new
      end

      def parent : Dir
        @parent || self
      end

      def size : Int64
        @size ||= files.map { |file| file.size }.sum +
                  dirs.map { |dir| dir.size }.sum
      end

      def traverse(&block : Dir -> Nil)
        yield self
        @dirs.each { |dir| dir.traverse(&block) }
      end

      def pretty_print(depth : Int64 = 0) : String
        indent = "  " * depth
        entries = Hash(String, String).new

        dirs.each do |dir|
          entries[dir.name] = dir.pretty_print(depth + 1)
        end
        files.each do |file|
          entries[file.name] = "#{indent}  - #{file.name} (file, size=#{file.size})\n"
        end

        "#{indent}- #{name} (dir)\n" + entries.keys.sort.map { |name| entries[name] }.join("")
      end
    end

    @root : Dir

    def initialize(input : String)
      @root = parse_output(input.strip("\n"))
    end

    def part1 : String
      sum : Int64 = 0

      @root.traverse do |dir|
        if dir.size <= 100000
          sum += dir.size
        end
      end

      sum.to_s
    end

    def part2 : String
      unused = 70000000 - @root.size
      needed = 30000000 - unused

      smallest_dir = @root
      @root.traverse do |dir|
        if dir.size >= needed && dir.size <= smallest_dir.size
          smallest_dir = dir
        end
      end

      smallest_dir.size.to_s
    end

    private def parse_output(output : String) : Dir
      root = Dir.new("/")
      dir : Dir = root

      output.lines.each do |line|
        if (m = line.match(/\A\$ cd (?P<dir_name>.+)\z/))
          if m["dir_name"] == "/"
            dir = root
          elsif m["dir_name"] == ".."
            dir = dir.parent
          else
            dir = dir.dirs.find! { |d| d.name == m["dir_name"] }
          end
        elsif line == "$ ls"
          # Nothing to do
        elsif (m = line.match(/\Adir (?P<dir_name>.+)\z/))
          dir.dirs << Dir.new(m["dir_name"], dir)
        elsif (m = line.match(/\A(?P<size>\d+) (?P<file_name>.+)\z/))
          dir.files << File.new(m["file_name"], m["size"].to_i64)
        else
          raise "Unexpected line: #{line}"
        end
      end

      root
    end
  end
end
