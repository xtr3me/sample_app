require 'test_helper'

class RankTest < ActiveSupport::TestCase
  test "Name can't be blank" do
    rank = Rank.new(score_from: 2, score_to: 3)
    rank.valid?
    error = rank.errors.full_messages
    assert_equal("Name can't be blank", error[0].to_s)
    assert_not rank.valid?
  end

  test 'Invalid score_from has to be lower than score_to' do
    rank = Rank.new(name: 'AA', score_from: 1.0, score_to: 0.9)
    assert_not rank.valid?
  end

  test 'Invalid score_from nil number' do
    rank = Rank.new(name: 'AA', score_from: nil, score_to: 0.9)
    assert_not rank.valid?
  end

  test 'Invalid score_to nil number' do
    rank = Rank.new(name: 'AA', score_from: 1.0, score_to: nil)
    assert_not rank.valid?
  end
  test 'Valid score_from has to be lower than score_to' do
    rank = Rank.new(name: 'AA', score_from: 0.8, score_to: 0.9)
    assert rank.valid?
  end

  test 'Valid score_to has to be higher than score_from' do
    rank = Rank.new(name: 'AA', score_from: 2, score_to: 3)
    assert rank.valid?
  end

  test 'Invalid score_to has to be higher than score_from' do
    rank = Rank.new(name: 'AA', score_from: 2, score_to: 3)
    assert rank.valid?
  end

  test 'Valid scores have a precision of one' do
    rank = Rank.new(name: 'AA', score_from: 1.1, score_to: 1.2)
    assert rank.valid?
  end

  test 'Invalid scores have a precision of one' do
    rank = Rank.new(name: 'AA', score_from: 1.122, score_to: 1.222)
    assert_not rank.valid?
  end

  test 'Invalid scores cannot overlap with other Ranks' do
    rank = Rank.create(name: 'AA', score_from: 1.1, score_to: 1.9)
    rank = Rank.new(name: 'AA', score_from: 1.0, score_to: 1.8)
    assert_not rank.valid?
  end

  test 'Valid scores cannot overlap with other Ranks' do
    rank = Rank.create(name: 'AA', score_from: 1.1, score_to: 1.9)
    rank = Rank.new(name: 'AA', score_from: 2, score_to: 3)
    assert rank.valid?
  end
end
