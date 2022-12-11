require "../spec_helper"

describe AoC2022::Day11 do
  it "solves part 1" do
    solver = AoC2022::Day11.new(File.read(File.join(__DIR__, "../fixtures/day11.txt")))
    solver.part1.should eq("10605")
  end

  it "solves part 2" do
    solver = AoC2022::Day11.new(File.read(File.join(__DIR__, "../fixtures/day11.txt")))
    solver.part2.should eq("2713310158")
  end
end
