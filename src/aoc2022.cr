require "./aoc2022/solver"
require "./aoc2022/day1"
require "./aoc2022/day2"
require "./aoc2022/day3"

module AoC2022
  SOLVERS = {
    1 => AoC2022::Day1,
    2 => AoC2022::Day2,
    3 => AoC2022::Day3,
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
