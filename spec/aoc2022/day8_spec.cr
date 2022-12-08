require "../spec_helper"

describe AoC2022::Day8 do
  it "solves part 1" do
    solver = AoC2022::Day8.new(File.read(File.join(__DIR__, "../fixtures/day8.txt")))
    solver.part1.should eq("21")
  end

  it "solves part 2" do
    solver = AoC2022::Day8.new(File.read(File.join(__DIR__, "../fixtures/day8.txt")))
    solver.part2.should eq("8")
  end
end
