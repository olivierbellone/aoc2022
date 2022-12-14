require "../spec_helper"

describe AoC2022::Day14 do
  it "solves part 1" do
    solver = AoC2022::Day14.new(File.read(File.join(__DIR__, "../fixtures/day14.txt")))
    solver.part1.should eq("24")
  end

  it "solves part 2" do
    solver = AoC2022::Day14.new(File.read(File.join(__DIR__, "../fixtures/day14.txt")))
    solver.part2.should eq("93")
  end
end
