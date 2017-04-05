require 'test_helper'

class RankTest < ActiveSupport::TestCase
  setup do
    @rank_one = ranks(:one)
    @rank_two= ranks(:two)
    @rank_three = ranks(:three)

  end

  test '#score_from_lower_than_score_to' do
    r = Rank.new(name: 'New name', score_from: 1, score_to: 2)
    r.valid? == false


    assert_equal(@rank_one.score_from_lower_than_score_to?, false)
    assert_equal(@rank_two.score_from_lower_than_score_to?, true)
    assert_equal(@rank_three.score_from_lower_than_score_to?, false)
  end


  test '#score_to_greater_than_score_from' do
    assert_equal(@rank_one.score_to_greater_than_score_from?, false)
    assert_equal(@rank_two.score_to_greater_than_score_from?, true)
    assert_equal(@rank_three.score_to_greater_than_score_from?, false)
  end

  test '#overlap_rank_instance' do
    assert_equal(@rank_one.overlap_rank_instance?, false)
  end
end
