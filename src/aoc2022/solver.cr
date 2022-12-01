module AoC2022
  abstract class Solver
    abstract def initialize(input : String)

    abstract def part1 : String

    abstract def part2 : String
  end
end
