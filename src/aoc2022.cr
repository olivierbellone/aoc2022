require "./aoc2022/solver"
require "./aoc2022/day1"
require "./aoc2022/day2"
require "./aoc2022/day3"
require "./aoc2022/day4"
require "./aoc2022/day5"
require "./aoc2022/day6"
require "./aoc2022/day7"
require "./aoc2022/day8"
require "./aoc2022/day9"
require "./aoc2022/day10"
require "./aoc2022/day11"
require "./aoc2022/day12"
require "./aoc2022/day13"
require "./aoc2022/day14"
require "./aoc2022/day15"
require "./aoc2022/day16"
require "./aoc2022/day17"
require "./aoc2022/day18"
require "./aoc2022/day19"
require "./aoc2022/day20"
require "./aoc2022/day21"
require "./aoc2022/day22"
require "./aoc2022/day23"
require "./aoc2022/day24"

module AoC2022
  SOLVERS = {
     1 => AoC2022::Day1,
     2 => AoC2022::Day2,
     3 => AoC2022::Day3,
     4 => AoC2022::Day4,
     5 => AoC2022::Day5,
     6 => AoC2022::Day6,
     7 => AoC2022::Day7,
     8 => AoC2022::Day8,
     9 => AoC2022::Day9,
    10 => AoC2022::Day10,
    11 => AoC2022::Day11,
    12 => AoC2022::Day12,
    13 => AoC2022::Day13,
    14 => AoC2022::Day14,
    15 => AoC2022::Day15,
    16 => AoC2022::Day16,
    17 => AoC2022::Day17,
    18 => AoC2022::Day18,
    19 => AoC2022::Day19,
    20 => AoC2022::Day20,
    21 => AoC2022::Day21,
    22 => AoC2022::Day22,
    23 => AoC2022::Day23,
    24 => AoC2022::Day24,
  }

  def self.main(args : Array(String))
    day, path = parse_args(args)

    solver = SOLVERS[day].new(File.read(path))

    puts(solver.part1)
    puts(solver.part2)
  end

  protected def self.parse_args(args : Array(String)) : Tuple(Int32, String)
    if args.size != 2
      STDERR.puts("Syntax: aoc2022 <day#> <input file>")
      exit 1
    end

    begin
      day = args[0].to_i
    rescue ArgumentError
      STDERR.puts("Invalid day number: #{args[0]}")
      STDERR.puts("Day number must be an integer")
      exit 1
    end

    unless SOLVERS.has_key?(day)
      STDERR.puts("Invalid day number: #{args[0]}")
      STDERR.puts("Valid day numbers: #{SOLVERS.keys.join(", ")}")
      exit 1
    end

    path = args[1]
    unless File.file?(path)
      STDERR.puts("Invalid input file: #{path}")
      exit 1
    end

    {day, path}
  end
end
