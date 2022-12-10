require "./solver"

module AoC2022
  class Day10 < Solver
    @program : Array(String)

    def initialize(input : String)
      @program = input.strip("\n").lines
    end

    def part1 : String
      x_values = execute

      20.step(to: x_values.size - 1, by: 40)
        .map { |cycle| cycle * x_values[cycle - 1] }
        .sum
        .to_s
    end

    def part2 : String
      draw(execute)
    end

    private def execute : Array(Int32)
      x_values = Array(Int32).new

      x = 1
      @program.each do |instruction|
        if instruction == "noop"
          x_values << x
        elsif m = instruction.match(/\Aaddx (?P<val>(-)?\d+)\z/)
          2.times { x_values << x }
          x += m["val"].to_i
        end
      end

      x_values
    end

    private def draw(values : Array(Int32)) : String
      (0..5).map do |v|
        (0..39).map do |h|
          x = values[v * 40 + h]
          ((x - h).abs <= 1) ? "#" : "."
        end.join("")
      end.join("\n")
    end
  end
end
