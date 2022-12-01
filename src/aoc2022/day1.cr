require "./solver"

module AoC2022
  class Day1 < Solver
    # list is an array of each elf's inventory, e.g.
    # [[1000, 2000, 3000], [4000], [5000, 6000], [7000, 8000, 9000], [10000]]
    property list : Array(Array(Int64))

    def initialize(input : String)
      @list = input
        .strip("\n")
        .split("\n\n")
        .map do |inv| inv.strip("\n")
          .split("\n")
          .map { |line| line.to_i64 }
        end
    end

    def part1 : String
      @list.map { |inv| inv.sum }.max.to_s
    end

    def part2 : String
      @list.map { |inv| inv.sum }.sort[-3..-1].sum.to_s
    end
  end
end
