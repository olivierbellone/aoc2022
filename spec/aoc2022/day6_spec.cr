require "../spec_helper"

describe AoC2022::Day6 do
  it "solves part 1" do
    [
      {"mjqjpqmgbljsphdztnvjfqwrcgsmlb", "7"},
      {"bvwbjplbgvbhsrlpgdmjqwftvncz", "5"},
      {"nppdvjthqldpwncqszvftbrmjlhg", "6"},
      {"nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", "10"},
      {"zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", "11"},
    ].each do |test_case|
      solver = AoC2022::Day6.new(test_case[0])
      solver.part1.should eq(test_case[1])
    end
  end

  it "solves part 2" do
    [
      {"mjqjpqmgbljsphdztnvjfqwrcgsmlb", "19"},
      {"bvwbjplbgvbhsrlpgdmjqwftvncz", "23"},
      {"nppdvjthqldpwncqszvftbrmjlhg", "23"},
      {"nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", "29"},
      {"zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", "26"},
    ].each do |test_case|
      solver = AoC2022::Day6.new(test_case[0])
      solver.part2.should eq(test_case[1])
    end
  end
end
