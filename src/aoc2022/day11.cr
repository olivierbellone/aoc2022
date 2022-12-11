require "./solver"

module AoC2022
  class Day11 < Solver
    class Monkey
      property items
      getter operation
      getter divisible_by
      getter throw_true
      getter throw_false
      @inspected : Int64
      property inspected

      def initialize(@items : Array(Int64), @operation : String, @divisible_by : Int32, @throw_true : Int32, @throw_false : Int32)
        @inspected = 0.to_i64
      end

      def clone : Monkey
        new_monkey = Monkey.new(@items.clone, @operation.dup, @divisible_by, @throw_true, @throw_false)
        new_monkey.inspected = inspected
        new_monkey
      end
    end

    @monkeys : Array(Monkey)
    @divisible_by_lcm : Int64

    def initialize(input : String)
      @monkeys = input.strip("\n").split("\n\n")
        .map do |blob|
          starting_items = Array(Int64).new
          operation = ""
          divisible_by = -1
          throw_false = -1
          throw_true = -1

          blob.lines.each do |line|
            if line.starts_with?("Monkey ")
              # nothing to do
              next
            elsif line.starts_with?("  Starting items: ")
              starting_items = line.gsub("  Starting items: ", "").split(", ").map { |i| i.to_i64 }
            elsif line.starts_with?("  Operation: new = ")
              operation = line.gsub("  Operation: new = ", "")
            elsif line.starts_with?("  Test: divisible by ")
              divisible_by = line.gsub("  Test: divisible by ", "").to_i
            elsif line.starts_with?("    If true: throw to monkey ")
              throw_true = line.gsub("    If true: throw to monkey ", "").to_i
            elsif line.starts_with?("    If false: throw to monkey ")
              throw_false = line.gsub("    If false: throw to monkey ", "").to_i
            else
              raise "Unexpected line: #{line}"
            end
          end

          Monkey.new(starting_items, operation, divisible_by, throw_true, throw_false)
        end

      @divisible_by_lcm = @monkeys.map {|m| m.divisible_by}.reduce(1.to_i64) { |acc, i| acc.lcm(i) }
    end

    def part1 : String
      monkeys = @monkeys.clone
      20.times { do_round(monkeys, true) }
      monkeys.map { |monkey| monkey.inspected }.sort[-2..-1].product.to_s
    end

    def part2 : String
      monkeys = @monkeys.clone
      10000.times { do_round(monkeys, false) }
      monkeys.map { |monkey| monkey.inspected }.sort[-2..-1].product.to_s
    end

    private def do_round(monkeys : Array(Monkey), relief : Bool)
      monkeys.each do |monkey|
        new_items = Array(Int64).new

        monkey.items.each do |item|
          monkey.inspected += 1
          new = eval(monkey.operation.gsub("old", item.to_s))
          if relief
            new = (new / 3).floor.to_i64
          end
          new_items << new % @divisible_by_lcm
        end

        new_items.each do |item|
          throw_to = (item % monkey.divisible_by == 0) ? monkey.throw_true : monkey.throw_false
          monkeys[throw_to].items << item
        end

        monkey.items = Array(Int64).new
      end
    end

    private def eval(s : String) : Int64
      a, op, b = s.split(" ", 3)
      case op
      when "+"
        a.to_i64 + b.to_i64
      when "-"
        a.to_i64 - b.to_i64
      when "*"
        a.to_i64 * b.to_i64
      else
        raise "Unexpected operator: #{op}"
      end
    end
  end
end
