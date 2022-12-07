require "../spec_helper"

describe AoC2022::Day7 do
  it "solves part 1" do
    solver = AoC2022::Day7.new(File.read(File.join(__DIR__, "../fixtures/day7.txt")))
    solver.part1.should eq("95437")
  end

  it "solves part 2" do
    solver = AoC2022::Day7.new(File.read(File.join(__DIR__, "../fixtures/day7.txt")))
    solver.part2.should eq("24933642")
  end
end
