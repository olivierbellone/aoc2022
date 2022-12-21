require "../spec_helper"

describe AoC2022::Day21 do
  it "solves part 1" do
    solver = AoC2022::Day21.new(File.read(File.join(__DIR__, "../fixtures/day21.txt")))
    solver.part1.should eq("152")
  end

  it "solves part 2" do
    solver = AoC2022::Day21.new(File.read(File.join(__DIR__, "../fixtures/day21.txt")))
    solver.part2.should eq("301")
  end
end
