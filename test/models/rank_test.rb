require '../test/test_helper'

class RankTest < ActiveSupport::TestCase
  setup do
    @test1 = ranks(:one)
    @test2 = ranks(:two)
  end

	test "Rank Invalid" do
    rank = Rank.new(name: @test1.name, score_from: 10, score_to: 1)
    assert_not rank.valid?
  end

   test "Rank Valid" do
    rank = Rank.new(name: @test2.name, score_from: 1, score_to: 10)
    assert rank.valid?
  end
end
