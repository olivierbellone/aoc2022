require "./solver"

module AoC2022
  struct Position
    getter x
    getter y

    def initialize(@x : Int32, @y : Int32)
    end
  end

  struct Node
    getter position
    getter elevation

    def initialize(@position : Position, @elevation : Int32)
    end
  end

  class Day12 < Solver
    @graph : Hash(Position, Node)
    @start : Node
    @destination : Node

    def initialize(input : String)
      @graph = Hash(Position, Node).new
      @start = Node.new(Position.new(-1, -1), -1)
      @destination = Node.new(Position.new(-1, -1), -1)

      input.strip("\n").lines.each_with_index do |line, y|
        line.chars.each_with_index do |char, x|
          position = Position.new(x, y)

          elevation = case char
                      when 'S'
                        0
                      when 'E'
                        25
                      else
                        char - 'a'
                      end

          @graph[position] = Node.new(position, elevation)

          if char == 'S'
            @start = @graph[position]
          elsif char == 'E'
            @destination = @graph[position]
          end
        end
      end
    end

    def part1 : String
      dist, prev = dijkstra(@graph, @start, false)

      shortest_path = path(prev, @start, @destination)

      (shortest_path.size - 1).to_s
    end

    def part2 : String
      dist, prev = dijkstra(@graph, @destination, true)

      shortest_path = @graph
        .values
        .select { |node| node.elevation == 0 }
        .map { |node| path(prev, @destination, node) }
        .reject { |path| path.empty? }
        .min_by { |path| path.size }

      (shortest_path.size - 1).to_s
    end

    private def dijkstra(nodes : Hash(Position, Node), source : Node, reverse : Bool = false) : Tuple(Hash(Node, Int32), Hash(Node, Node))
      q = Set(Node).new
      dist = Hash(Node, Int32).new(default_value: Int32::MAX)
      prev = Hash(Node, Node).new

      nodes.each do |position, node|
        q << node
      end
      dist[source] = 0

      until q.empty?
        u = q.min_by { |node| dist[node] }
        q.delete(u)

        neigbors(u, reverse).select { |node| q.includes?(node) }.each do |v|
          next if dist[u] == Int32::MAX
          alt = dist[u] + 1
          if alt < dist[v]
            dist[v] = alt
            prev[v] = u
          end
        end
      end

      return {dist, prev}
    end

    # Returns the set of nodes that can be visited from a given node (i.e. the vertex's edges).
    private def neigbors(node, reverse : Bool) : Set(Node)
      edges = Set(Node).new

      [{0, -1}, {0, 1}, {-1, 0}, {1, 0}].each do |x_offset, y_offset|
        neighbor_position = Position.new(node.position.x + x_offset, node.position.y + y_offset)
        next unless @graph.has_key?(neighbor_position)

        if !reverse && @graph[neighbor_position].elevation <= node.elevation + 1
          edges << @graph[neighbor_position]
        elsif reverse && @graph[neighbor_position].elevation >= node.elevation - 1
          edges << @graph[neighbor_position]
        end
      end

      edges
    end

    # Returns the shortest path from source to target, or an empty array if no path exists.
    private def path(prev : Hash(Node, Node), source : Node, target : Node) : Array(Position)
      s = Array(Position).new

      u : Node? = target
      if prev.has_key?(u) || u == source
        while !u.nil?
          s.insert(0, u.position)
          u = prev.fetch(u, nil)
        end
      end

      s
    end
  end
end
