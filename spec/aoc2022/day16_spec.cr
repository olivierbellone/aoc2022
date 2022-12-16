require "../spec_helper"

describe AoC2022::Day16 do
  it "solves part 1" do
    solver = AoC2022::Day16.new(File.read(File.join(__DIR__, "../fixtures/day16.txt")))
    solver.part1.should eq("1651")
  end

  it "solves part 2" do
    solver = AoC2022::Day16.new(File.read(File.join(__DIR__, "../fixtures/day16.txt")))
    solver.part2.should eq("1707")
  end
end
