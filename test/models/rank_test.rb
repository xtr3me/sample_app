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
end
