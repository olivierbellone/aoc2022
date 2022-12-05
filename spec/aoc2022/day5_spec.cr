require "../spec_helper"

describe AoC2022::Day5 do
  it "solves part 1" do
    solver = AoC2022::Day5.new(File.read(File.join(__DIR__, "../fixtures/day5.txt")))
    solver.part1.should eq("CMZ")
  end

  it "solves part 2" do
    solver = AoC2022::Day5.new(File.read(File.join(__DIR__, "../fixtures/day5.txt")))
    solver.part2.should eq("MCD")
  end
end
