require "../spec_helper"

describe AoC2022::Day24 do
  it "solves part 1" do
    solver = AoC2022::Day24.new(File.read(File.join(__DIR__, "../fixtures/day24.txt")))
    solver.part1.should eq("18")
  end

  it "solves part 2" do
    solver = AoC2022::Day24.new(File.read(File.join(__DIR__, "../fixtures/day24.txt")))
    solver.part2.should eq("54")
  end
end
