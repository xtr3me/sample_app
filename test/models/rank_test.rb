require 'test_helper'

class RankTest < ActiveSupport::TestCase
	def setup
		Rank.create(name: 'Sample', score_from: 10, score_to: 20)
		@rank = Rank.new(name: 'Test', score_from: 50, score_to: 100)
	end

  test 'valid rank' do
  	assert @rank.valid?
  end

  test 'rank without name' do
		@rank.name = nil
    refute @rank.valid?, 'saved rank without a name'
    assert_not_nil @rank.errors[:name], 'no validation error for name present'
  end

  test 'rank with score_from > score_to' do
  	@rank.score_to = 30
    refute @rank.valid?, 'set score_to lower than score_from'
    assert_not_nil @rank.errors[:name], 'no validation error for name present'
  end

  test 'rank with alphabetical scores' do
  	@rank.score_to = "asdasdasd"
    refute @rank.valid?, 'set score_to alphabetical'
    assert_not_nil @rank.errors[:name], 'no validation error for name present'
  end

  test 'rank with score already in database' do
  	@rank.score_from = 15
    refute @rank.valid?, 'set score_from to score already in database'
    assert_not_nil @rank.errors[:name], 'no validation error for name present'
  end

  test 'rank with more than one decimal' do
  	@rank.score_to = 100.12345
    refute @rank.valid?, 'set score_to with more than one decimal'
    assert_not_nil @rank.errors[:name], 'no validation error for name present'
  end
end
