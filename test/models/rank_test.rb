require 'test_helper'

class RankTest < ActiveSupport::TestCase
  test "score_from should be lower than score_to" do
    rank = ranks(:one)
    rank.score_from = 20.0
    rank.score_to = 19.0
    assert_not rank.valid?, "Expected rank to be invalid"
    assert_match /must be lower than/, rank.errors[:score_from].first
    assert_match /must be higher than/, rank.errors[:score_to].first
  end

  test "score ranges should not overlap" do
    rank_one = ranks(:one)
    rank_two = ranks(:two)
    rank_two.score_from = rank_one.score_from + 0.2
    rank_two.score_to   = rank_one.score_to + 0.2
    assert_not rank_two.valid?, "Expected rank_two to be invalid"
    assert_match /must not overlap/, rank_two.errors[:base].first
    assert_match /with.*MyStringOne/, rank_two.errors[:base].first
  end

  # TODO: tests of overlapping validation in more complex situations
end
