require "../spec_helper"

describe AoC2022::Day19 do
  it "solves part 1" do
    solver = AoC2022::Day19.new(File.read(File.join(__DIR__, "../fixtures/day19.txt")))
    solver.part1.should eq("33")
  end

  it "solves part 2" do
    solver = AoC2022::Day19.new(File.read(File.join(__DIR__, "../fixtures/day19.txt")))
    solver.part2.should eq("3472")
  end
end
