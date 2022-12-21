require "./solver"

module AoC2022
  class Day21 < Solver
    @variables : Hash(String, Int64)
    @operations : Hash(String, String)

    def initialize(input : String)
      @variables = Hash(String, Int64).new
      @operations = Hash(String, String).new

      input.strip("\n").lines.each do |line|
        name, job = line.split(": ", 2)
        if job =~ /[-]?\d+/
          @variables[name] = job.to_i64
        else
          @operations[name] = job
        end
      end
    end

    def part1 : String
      operations = @operations.dup
      variables = @variables.dup

      simplify!(operations, variables)

      variables["root"].to_s
    end

    def part2 : String
      operations = @operations.dup
      variables = @variables.dup

      variables.delete("humn")
      root = operations.delete("root")
      raise "No root operation" unless root
      n1, _, n2 = root.split(" ", 3)

      simplify!(operations, variables)

      guess = 0_i64

      while true
        working_operations = operations.dup
        working_variables = variables.dup
        working_variables["humn"] = guess

        simplify!(working_operations, working_variables)

        diff = working_variables[n1] - working_variables[n2]
        break if diff == 0
        guess += diff > 100 ? diff // 100 : 1
      end

      guess.to_s
    end

    private def simplify!(operations : Hash(String, String), variables : Hash(String, Int64))
      while true
        modified = false

        operations.each do |name, operation|
          n1, op, n2 = operation.split(" ", 3)
          next unless [n1, n2].all? { |var_name| variables.keys.includes?(var_name) }

          variables[name] = calc(op, variables[n1], variables[n2])
          operations.delete(name)
          modified = true
        end

        break unless modified
      end
    end

    private def calc(op : String, n1 : Int64, n2 : Int64) : Int64
      case op
      when "+"
        n1 + n2
      when "-"
        n1 - n2
      when "*"
        n1 * n2
      when "/"
        n1 // n2
      else
        raise "Unexpected operator: #{op}"
      end
    end
  end
end
