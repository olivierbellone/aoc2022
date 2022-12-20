require "./solver"

module AoC2022
  class Day20 < Solver
    struct Entry
      getter value
      getter index

      def initialize(@value : Int64, @index : Int32)
      end
    end

    @file : Array(Entry)

    def initialize(input : String)
      @file = input.strip("\n").lines.map_with_index { |line, i| Entry.new(line.to_i64, i) }
    end

    def part1 : String
      file = @file.dup
      mix(file)
      i_zero = file.index! { |entry| entry.value == 0 }
      [1000, 2000, 3000].map { |i| file[(i_zero + i) % file.size].value }.sum.to_s
    end

    def part2 : String
      file = @file.map { |entry| Entry.new(entry.value * 811589153_i64, entry.index) }
      mix(file, 10)
      i_zero = file.index! { |entry| entry.value == 0 }
      [1000, 2000, 3000].map { |i| file[(i_zero + i) % file.size].value }.sum.to_s
    end

    private def mix(file : Array(Entry), times : Int32 = 1)
      times.times do
        file.size.times do |n|
          i = file.index! { |entry| entry.index == n }
          entry = file.delete_at(i)
          file.insert((entry.value + i) % file.size, entry)
        end
      end
    end
  end
end
