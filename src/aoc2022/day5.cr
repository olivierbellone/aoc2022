require "./solver"

module AoC2022
  class Day5 < Solver
    property initial_stacks : Array(Array(Char))

    property procedure : Array(Tuple(Int32, Int32, Int32))

    def initialize(input : String)
      parts = input.strip("\n").split("\n\n")

      num_stacks = parts[0].lines.last.scan(/\d+/).last[0].to_i
      @initial_stacks = (0...num_stacks).map { Array(Char).new }
      parts[0].lines[0..-2].reverse.each do |line|
        (0...num_stacks).each do |i|
          c = line[(i * 4) + 1]
          next if c == ' '
          initial_stacks[i] << c
        end
      end

      @procedure = parts[1].lines.map do |line|
        m = line.match(/\Amove (?P<move>\d+) from (?P<from>\d+) to (?<to>\d+)\z/)
        if m
          { m["move"].to_i, m["from"].to_i, m["to"].to_i }
        else
          # this cannot happen but i dunno how to tell the compiler...
          { -1, -1, -1 }
        end
      end
    end

    def part1 : String
      new_stacks = initial_stacks.clone
      execute_procedure_9000(new_stacks, @procedure)
      new_stacks.map { |stack| stack.last }.join("")
    end

    def part2 : String
      new_stacks = initial_stacks.clone
      execute_procedure_9001(new_stacks, @procedure)
      new_stacks.map { |stack| stack.last }.join("")
    end

    private def execute_procedure_9000(stacks : Array(Array(Char)), procedure : Array(Tuple(Int32, Int32, Int32))) : Array(Array(Char))
      procedure.each do |step|
        execute_step_9000(stacks, step)
      end
      stacks
    end

    private def execute_step_9000(stacks : Array(Array(Char)), step : Tuple(Int32, Int32, Int32)) : Array(Array(Char))
      move, from, to = step
      move.times do |n|
        stacks[to - 1].push(stacks[from - 1].pop)
      end
      stacks
    end

    private def execute_procedure_9001(stacks : Array(Array(Char)), procedure : Array(Tuple(Int32, Int32, Int32))) : Array(Array(Char))
      procedure.each do |step|
        execute_step_9001(stacks, step)
      end
      stacks
    end

    private def execute_step_9001(stacks : Array(Array(Char)), step : Tuple(Int32, Int32, Int32)) : Array(Array(Char))
      move, from, to = step
      stacks[to - 1].concat(stacks[from - 1].pop(move))
      stacks
    end
  end
end
