require "../spec_helper"

describe AoC2022::Day15 do
  it "solves part 1" do
    solver = AoC2022::Day15.new(File.read(File.join(__DIR__, "../fixtures/day15.txt")))
    solver.part1(row: 10).should eq("26")
  end

  it "solves part 2" do
    solver = AoC2022::Day15.new(File.read(File.join(__DIR__, "../fixtures/day15.txt")))
    solver.part2(max: 20).should eq("56000011")
  end
end
