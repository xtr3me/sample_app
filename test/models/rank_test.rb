require 'test_helper'

class RankTest < ActiveSupport::TestCase
  setup do
    @rank = ranks(:one)
    @rank2 = ranks(:two)
    @rank3 = ranks(:three)
    Rank.create(name: @rank.name, score_from: 1.5, score_to: 4.5)
  end

  test "invalid Rank" do
    rank = Rank.new(name: @rank2.name, score_from: 2.5, score_to: 6.5)
    assert_not rank.valid?
  end

  test "when ranks is in between" do
    rank = Rank.new(name: "Rank 4", score_from: 2.5, score_to: 3.5)
    assert_not rank.valid?
  end
  test "valid Rank" do
    rank = Rank.new(name: @rank3.name, score_from: @rank3.score_from, score_to: @rank3.score_to)
    assert rank.valid?
  end
end
