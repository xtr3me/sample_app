require 'test_helper'

class RankTest < ActiveSupport::TestCase

  test "rank attributes must not be empty" do
    rank = Rank.new
    assert rank.invalid?
    assert rank.errors[:score_from].any?
    assert rank.errors[:score_to].any?
  end

  test "scores have a precision of 0.1" do
    rank = Rank.new(:score_from => 1.2345)
    assert_equal rank.score_from, 1.2
  end

  test "score_to should be higher than score_from" do
    rank = Rank.new(:score_to => 6, :score_from => 5)
    assert rank.valid?
    assert_equal rank.errors[:score_to], [6], rank.errors.to_h
  end
end
