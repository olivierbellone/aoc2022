require "./solver"

module AoC2022
  class Day19 < Solver
    struct Blueprint
      getter id
      getter ore_bot_ore
      getter clay_bot_ore
      getter obsidian_bot_ore
      getter obsidian_bot_clay
      getter geode_bot_ore
      getter geode_bot_obsidian

      def initialize(
        @id : Int32,
        @ore_bot_ore : Int32,
        @clay_bot_ore : Int32,
        @obsidian_bot_ore : Int32,
        @obsidian_bot_clay : Int32,
        @geode_bot_ore : Int32,
        @geode_bot_obsidian : Int32
      )
      end
    end

    struct State
      getter blueprint
      getter minutes
      getter ore_bot_count
      getter clay_bot_count
      getter obsidian_bot_count
      getter geode_bot_count
      getter ore
      getter clay
      getter obsidian
      getter geode

      def initialize(
        @blueprint : Blueprint,
        @minutes : Int32,
        @ore_bot_count : Int32,
        @clay_bot_count : Int32,
        @obsidian_bot_count : Int32,
        @geode_bot_count : Int32,
        @ore : Int32,
        @clay : Int32,
        @obsidian : Int32,
        @geode : Int32
      )
      end

      def compute_next : State
        State.new(
          blueprint,
          minutes - 1,
          ore_bot_count,
          clay_bot_count,
          obsidian_bot_count,
          geode_bot_count,
          ore + ore_bot_count,
          clay + clay_bot_count,
          obsidian + obsidian_bot_count,
          geode + geode_bot_count,
        )
      end

      def can_build_ore_bot? : Bool
        ore >= blueprint.ore_bot_ore &&
          ore_bot_count < [blueprint.clay_bot_ore, blueprint.obsidian_bot_ore, blueprint.geode_bot_ore].max
      end

      def build_ore_bot : State
        raise "Cannot build ore bot" unless can_build_ore_bot?
        State.new(
          blueprint,
          minutes,
          ore_bot_count + 1,
          clay_bot_count,
          obsidian_bot_count,
          geode_bot_count,
          ore - blueprint.ore_bot_ore,
          clay,
          obsidian,
          geode,
        )
      end

      def can_build_clay_bot? : Bool
        ore >= blueprint.clay_bot_ore &&
          clay_bot_count < blueprint.obsidian_bot_clay
      end

      def build_clay_bot : State
        raise "Cannot build clay bot" unless can_build_clay_bot?
        State.new(
          blueprint,
          minutes,
          ore_bot_count,
          clay_bot_count + 1,
          obsidian_bot_count,
          geode_bot_count,
          ore - blueprint.clay_bot_ore,
          clay,
          obsidian,
          geode,
        )
      end

      def can_build_obsidian_bot? : Bool
        ore >= blueprint.obsidian_bot_ore && clay >= blueprint.obsidian_bot_clay &&
          obsidian_bot_count < blueprint.geode_bot_obsidian
      end

      def build_obsidian_bot : State
        raise "Cannot build obsidian bot" unless can_build_obsidian_bot?
        State.new(
          blueprint,
          minutes,
          ore_bot_count,
          clay_bot_count,
          obsidian_bot_count + 1,
          geode_bot_count,
          ore - blueprint.obsidian_bot_ore,
          clay - blueprint.obsidian_bot_clay,
          obsidian,
          geode,
        )
      end

      def can_build_geode_bot? : Bool
        ore >= blueprint.geode_bot_ore && obsidian >= blueprint.geode_bot_obsidian
      end

      def build_geode_bot : State
        raise "Cannot build geode bot" unless can_build_geode_bot?
        State.new(
          blueprint,
          minutes,
          ore_bot_count,
          clay_bot_count,
          obsidian_bot_count,
          geode_bot_count + 1,
          ore - blueprint.geode_bot_ore,
          clay,
          obsidian - blueprint.geode_bot_obsidian,
          geode,
        )
      end

      def can_hoard? : Bool
        ore < 2 * [blueprint.geode_bot_ore, blueprint.obsidian_bot_ore, blueprint.clay_bot_ore].max &&
          clay < 3 * blueprint.obsidian_bot_clay
      end
    end

    @blueprints : Array(Blueprint)

    def initialize(input : String)
      @blueprints = input.strip("\n").lines
        .map do |line|
          n = line.scan(/(\d+)/).flatten.map { |m| m[0].to_i }
          Blueprint.new(n[0], n[1], n[2], n[3], n[4], n[5], n[6])
        end
    end

    def part1 : String
      @blueprints.map { |blueprint| dfs(blueprint, 24) * blueprint.id }.sum.to_s
    end

    def part2 : String
      @blueprints[0..2].map { |blueprint| dfs(blueprint, 32) }.product.to_s
    end

    private def dfs(blueprint : Blueprint, minutes : Int32) : Int32
      best = 0
      queue = [State.new(blueprint, minutes, 1, 0, 0, 0, 0, 0, 0, 0)]
      visited = Set(State).new

      while !queue.empty?
        curr = queue.shift

        next if visited.includes?(curr)

        visited << curr
        if curr.minutes == 0
          best = [best, curr.geode].max
        else
          nxt = curr.compute_next

          if curr.can_build_geode_bot?
            queue << nxt.build_geode_bot
          else
            queue << nxt.build_obsidian_bot if curr.can_build_obsidian_bot?
            queue << nxt.build_clay_bot if curr.can_build_clay_bot?
            queue << nxt.build_ore_bot if curr.can_build_ore_bot?
          end

          queue << nxt if !curr.can_build_geode_bot? && curr.can_hoard?
        end
      end

      best
    end
  end
end
