require "./solver"

module AoC2022
  class Day24 < Solver
    struct Position
      property x
      property y

      def initialize(@x : Int32, @y : Int32)
      end
    end

    NORTH = 0
    SOUTH = 1
    WEST  = 2
    EAST  = 3

    BLIZZARD_CHARS = {
      '^' => NORTH,
      'v' => SOUTH,
      '<' => WEST,
      '>' => EAST,
    }

    BLIZZARD_OFFSETS = {
      NORTH => {0, -1},
      SOUTH => {0, 1},
      WEST  => {-1, 0},
      EAST  => {1, 0},
    }

    @ground : Set(Position)
    @blizzards : Array(Tuple(Position, Int32))
    @start : Position
    @goal : Position

    def initialize(input : String)
      @ground = Set(Position).new
      @blizzards = Array(Tuple(Position, Int32)).new

      input.strip("\n").lines.each_with_index do |line, y|
        line.chars.each_with_index do |c, x|
          case c
          when '.'
            @ground << Position.new(x, y)
          when '^', 'v', '<', '>'
            @ground << Position.new(x, y)
            @blizzards << {Position.new(x, y), BLIZZARD_CHARS[c]}
          end
        end
      end

      top_row = @ground.select { |pos| pos.y == 0 }
      raise "Top row must have a single non-wall position." unless top_row.size == 1
      @start = top_row[0]

      bottom_row = @ground.select { |pos| pos.y == @ground.map { |pos| pos.y }.max }
      raise "Bottom row must have a single non-wall position." unless bottom_row.size == 1
      @goal = bottom_row[0]
    end

    def part1 : String
      blizzards = @blizzards.dup
      minute, _ = explore(blizzards, @start, @goal)
      minute.to_s
    end

    def part2 : String
      blizzards = @blizzards.dup
      total_time = 0
      [
        {@start, @goal},
        {@goal, @start},
        {@start, @goal},
      ].each do |start, goal|
        minute, blizzards = explore(blizzards, start, goal)
        total_time += minute
      end
      total_time.to_s
    end

    private def explore(blizzards : Array(Tuple(Position, Int32)), start : Position, goal : Position) : Tuple(Int32, Array(Tuple(Position, Int32)))
      possible = Set(Position).new
      possible << start

      minute = 0

      while true
        minute += 1

        blizzards = update_blizzards(blizzards)
        non_navigable = blizzards.map { |pos, _dir| pos }

        next_possible = Set(Position).new

        possible.each do |prev|
          possible_moves(prev).each do |move|
            if @ground.includes?(move) && !non_navigable.includes?(move)
              next_possible << move
            end
          end
        end

        break if next_possible.includes?(goal)

        possible = next_possible
      end

      {minute, blizzards}
    end

    private def possible_moves(position : Position) : Array(Position)
      [
        Position.new(position.x, position.y),
        Position.new(position.x, position.y - 1),
        Position.new(position.x, position.y + 1),
        Position.new(position.x - 1, position.y),
        Position.new(position.x + 1, position.y),
      ]
    end

    private def update_blizzards(blizzards : Array(Tuple(Position, Int32))) : Array(Tuple(Position, Int32))
      blizzards.map do |position, direction|
        x_offset, y_offset = BLIZZARD_OFFSETS[direction]
        new_position = Position.new(position.x + x_offset, position.y + y_offset)

        unless @ground.includes?(new_position)
          case direction
          when NORTH
            new_position = Position.new(position.x, @ground.select { |pos| pos.x == position.x }.map { |pos| pos.y }.max)
          when SOUTH
            new_position = Position.new(position.x, @ground.select { |pos| pos.x == position.x }.map { |pos| pos.y }.min)
          when WEST
            new_position = Position.new(@ground.select { |pos| pos.y == position.y }.map { |pos| pos.x }.max, position.y)
          when EAST
            new_position = Position.new(@ground.select { |pos| pos.y == position.y }.map { |pos| pos.x }.min, position.y)
          end
        end
        {new_position, direction}
      end
    end

    private def get_boundaries(ground : Set(Position)) : Tuple(Position, Position)
      y_min = ground.map { |position| position.y }.min
      y_max = ground.map { |position| position.y }.max
      x_min = ground.map { |position| position.x }.min
      x_max = ground.map { |position| position.x }.max

      {Position.new(x_min, y_min), Position.new(x_max, y_max)}
    end

    private def draw(blizzards : Array(Tuple(Position, Int32))) : String
      reversed_blizzard_chars = BLIZZARD_CHARS.invert
      pos_min, pos_max = get_boundaries(@ground)
      buf = ""

      (pos_min.y..pos_max.y).each do |y|
        ((pos_min.x - 1)..(pos_max.x + 1)).each do |x|
          unless @ground.includes?(Position.new(x, y))
            buf += "#"
            next
          end

          blizzards_at_position = blizzards.select { |pos, _dir| pos == Position.new(x, y) }
          if blizzards_at_position.empty?
            buf += "."
          elsif blizzards_at_position.size == 1
            blizzard_direction = blizzards_at_position.first[1]
            buf += reversed_blizzard_chars[blizzard_direction]
          elsif blizzards_at_position.size <= 9
            buf += blizzards_at_position.size.to_s
          else
            buf += "*"
          end
        end
        buf += "\n"
      end

      buf
    end
  end
end
