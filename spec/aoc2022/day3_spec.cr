require "../spec_helper"

describe AoC2022::Day3 do
  it "solves part 1" do
    solver = AoC2022::Day3.new(File.read(File.join(__DIR__, "../fixtures/day3.txt")))
    solver.part1.should eq("157")
  end

  it "solves part 2" do
    solver = AoC2022::Day3.new(File.read(File.join(__DIR__, "../fixtures/day3.txt")))
    solver.part2.should eq("70")
  end
end
