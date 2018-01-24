require 'test_helper'

class RankTest < ActiveSupport::TestCase

  test "rank attributes must not be empty" do
    rank = Rank.new(:score_to => 2, :score_from => 3)
    assert rank.invalid?
    assert_equal "Score_from cannot be blank", rank.errors[:score_from]
    assert_equal "Score_to cannot be blank", rank.errors[:score_to]
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
    assert_equal rank.errors[:score_from], []
    assert rank.errors[:score_to]
    assert rank.errors[:score_from]
  end

  test "score_from should be lower than score_to" do
    rank = Rank.new(:score_to => 2, :score_from => 1)
    assert rank.valid?
    assert rank.errors[:score_to].blank?
    assert rank.errors[:score_from].blank?
  end

  test "rank search scores" do
    rank1 = Rank.new(:score_from => 1, :score_to => 5)
    rank2 = Rank.new(:score_from => 6, :score_to => 10)
    rank3 = Rank.new(:score_from => 9, :score_to => 15)
    rank1.save
    rank2.save
    rank3.save
    assert_include(Rank.rank_search_scores(1), rank1)
    refute_include(Rank.rank_search_scores(1), rank2)
  end

end
