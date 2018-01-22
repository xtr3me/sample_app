require 'test_helper'

class RankTest < ActiveSupport::TestCase

  test "rank attributes must not be empty" do
    rank = Rank.new(:score_to => 2, :score_from => 3)
    assert rank.invalid?
    assert rank.errors[:score_from].any?
    assert rank.errors[:score_to].any?
  end

  test "scores have a precision of 0.1" do
    rank = Rank.new(:score_from => 1.2345, :score_to => 2.2345)
    rank.save
    assert_equal 1.2, rank.score_from
    assert_equal 2.2, rank.score_to
  end

  test "score_to should be higher than score_from" do
    rank = Rank.new(:score_to => 2, :score_from => 1)
    assert rank.valid?
    # assert_equal [], "score to should be higher!"
    assert rank.errors[:score_to]
    assert rank.errors[:score_from]
  end

  test "score_from should lower than score_to" do
    rank = Rank.new(:score_to => 2, :score_from => 1)
    assert rank.valid?
    assert rank.errors[:score_to]
    assert rank.errors[:score_from]
  end

  # test "scores cannot overlap with other ranks" do
  # rank =  Rank.new(:score_to => 5, :score_from => 5)
  # assert rank.valid?
  # assert rank.errors
  # end
end
