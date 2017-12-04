require 'test_helper'

class RankTest < ActiveSupport::TestCase
  test 'score_from should be lower than score_to' do
    rank = Rank.new(name: 'Rank', score_from: 1.0, score_to: 0.9)
    assert_not rank.valid?
  end

  test 'score_to should be higher than score_from' do
    rank = Rank.new(name: 'Rank', score_from: 1.0, score_to: 0.9)
    assert_not rank.valid?
  end

  test 'should not have overlaping other ranks - score_from within existing rank' do
    rank = Rank.new(name: 'Rank', score_from: 1.4, score_to: 2.1)
    assert_not rank.valid?
  end

  test 'should not have overlaping other ranks - score_to within existing rank' do
    rank = Rank.new(name: 'Rank', score_from: 0.5, score_to: 1.4)
    assert_not rank.valid?
  end

  test 'should not have overlaping other ranks - scores within existing range' do
    rank = Rank.new(name: 'Rank', score_from: 1.1, score_to: 1.4)
    assert_not rank.valid?
  end

  test 'should not have overlaping other ranks - existing range within scores' do
    rank = Rank.new(name: 'Rank', score_from: 0.1, score_to: 1.6)
    assert_not rank.valid?
  end

  test 'score_from should have a precision of 0.1' do
    rank = Rank.new(name: 'Rank', score_from: 1.42, score_to: 2.1)
    assert_not rank.valid?
  end

  test 'score_to should have a precision of 0.1' do
    rank = Rank.new(name: 'Rank', score_from: 1.4, score_to: 2.21)
    assert_not rank.valid?
  end
end
