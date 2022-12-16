require "./solver"

module AoC2022
  class Day16 < Solver
    @flow_rates : Hash(String, Int64)
    @leads_to : Hash(String, Array(String))

    @valve_id : Hash(String, Int64)
    @all_mask : Int64

    @memo : Hash(String, Array(Array(Int64)))

    def initialize(input : String)
      @flow_rates = Hash(String, Int64).new
      @leads_to = Hash(String, Array(String)).new

      input.strip("\n").lines
        .each do |line|
          m = line.match(/\AValve (?P<valve>\w+) has flow rate=(?P<flow_rate>\d+); tunnel[s]? lead[s]? to valve[s]? (?P<leads_to>.+)\z/)
          raise "Unexpected line: #{line}" if m.nil?
          @flow_rates[m["valve"]] = m["flow_rate"].to_i64
          @leads_to[m["valve"]] = m["leads_to"].split(", ")
        end

      # Assign consecutive IDs to all valves with a non-zero flow rate
      @valve_id = @flow_rates.select { |_, rate| rate > 0 }.keys.map_with_index { |u, i| {u, i.to_i64} }.to_h

      # @all_mask is the mask that covers all valves with a non-zero flow rate
      @all_mask = (1_i64 << @valve_id.size) - 1

      # Then assign IDs to valves with zero flow rates
      @flow_rates.select { |_, rate| rate == 0 }.keys.each do |u|
        @valve_id[u] = @valve_id.size
      end

      @memo = @flow_rates.keys.map { |u| {u, (0..30).map { |t| (0..@all_mask).map { -1_i64 } }} }.to_h
    end

    def part1 : String
      dp("AA", 30, @all_mask).to_s
    end

    def part2 : String
      (0..@all_mask).map { |mask| dp("AA", 26, @all_mask - mask) + dp("AA", 26, mask) }.max.to_s
    end

    def dp(u : String, t : Int64, mask : Int64) : Int64
      return 0_i64 if t == 0

      if @memo[u][t][mask] == -1
        best = @leads_to[u].map { |v| dp(v, t - 1, mask) }.max
        bit = (1_i64 << @valve_id[u])
        if bit & mask > 0
          best = [best, dp(u, t - 1, mask - bit) + @flow_rates[u] * (t - 1)].max
        end
        @memo[u][t][mask] = best
      end

      @memo[u][t][mask]
    end
  end
end
