require "./solver"

module AoC2022
  class Day23 < Solver
    struct Position
      property x
      property y

      def initialize(@x : Int32, @y : Int32)
      end
    end

    @elves : Set(Position)

    def initialize(input : String)
      @elves = Set(Position).new

      input.strip("\n").lines
        .each_with_index do |line, y|
          line.chars.each_with_index do |c, x|
            @elves << Position.new(x, y) if c == '#'
          end
        end
    end

    def part1 : String
      elves = @elves.dup
      (0..9).each do |round|
        elves = do_round(elves, round)
      end

      pos_min, pos_max = get_boundaries(elves)

      (pos_min.y..pos_max.y).map do |y|
        (pos_min.x..pos_max.x).map do |x|
          elves.includes?(Position.new(x, y)) ? 0 : 1
        end.reduce(0) { |s, acc| acc + s }
      end.reduce(0) { |s, acc| acc + s }.to_s
    end

    def part2 : String
      elves = @elves.dup

      round = 0
      while true
        new_elves = do_round(elves, round)
        round += 1
        break if new_elves == elves
        elves = new_elves
      end

      round.to_s
    end

    private def do_round(elves : Set(Position), first_direction : Int32) : Set(Position)
      proposals = Hash(Position, Position).new

      elves.each do |elf|
        next if adjacent(elf).all? { |adj| !elves.includes?(adj) }

        (0..3).each do |i|
          direction = (first_direction + i) % 4

          case direction
          when 0
            if north(elf).all? { |adj| !elves.includes?(adj) }
              proposals[elf] = Position.new(elf.x, elf.y - 1)
              break
            end
          when 1
            if south(elf).all? { |adj| !elves.includes?(adj) }
              proposals[elf] = Position.new(elf.x, elf.y + 1)
              break
            end
          when 2
            if west(elf).all? { |adj| !elves.includes?(adj) }
              proposals[elf] = Position.new(elf.x - 1, elf.y)
              break
            end
          when 3
            if east(elf).all? { |adj| !elves.includes?(adj) }
              proposals[elf] = Position.new(elf.x + 1, elf.y)
              break
            end
          end
        end
      end

      destinations = proposals.values
      dupes = destinations.select { |v| destinations.count(v) >= 2 }
      proposals.select! { |_, v| !dupes.includes?(v) }

      elves.map { |elf| proposals.fetch(elf, elf) }.to_set
    end

    private def adjacent(position : Position) : Array(Position)
      r = Array(Position).new

      [-1, 0, 1].each do |y_offset|
        [-1, 0, 1].each do |x_offset|
          next if x_offset == 0 && y_offset == 0
          r << Position.new(position.x + x_offset, position.y + y_offset)
        end
      end

      r
    end

    private def north(position : Position) : Array(Position)
      [-1, 0, 1].map { |x_offset| Position.new(position.x + x_offset, position.y - 1) }
    end

    private def south(position : Position) : Array(Position)
      [-1, 0, 1].map { |x_offset| Position.new(position.x + x_offset, position.y + 1) }
    end

    private def west(position : Position) : Array(Position)
      [-1, 0, 1].map { |y_offset| Position.new(position.x - 1, position.y + y_offset) }
    end

    private def east(position : Position) : Array(Position)
      [-1, 0, 1].map { |y_offset| Position.new(position.x + 1, position.y + y_offset) }
    end

    private def get_boundaries(elves : Set(Position)) : Tuple(Position, Position)
      y_min = elves.map { |elf| elf.y }.min
      y_max = elves.map { |elf| elf.y }.max
      x_min = elves.map { |elf| elf.x }.min
      x_max = elves.map { |elf| elf.x }.max

      {Position.new(x_min, y_min), Position.new(x_max, y_max)}
    end

    private def draw(elves : Set(Position)) : String
      pos_min, pos_max = get_boundaries(elves)
      buf = ""

      (pos_min.y..pos_max.y).each do |y|
        (pos_min.x..pos_max.x).each do |x|
          buf += elves.includes?(Position.new(x, y)) ? "#" : "."
        end
        buf += "\n"
      end

      buf
    end
  end
end
