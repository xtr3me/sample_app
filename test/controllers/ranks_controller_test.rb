require 'test_helper'

class RanksControllerTest < ActionController::TestCase
  setup do
    @rank = ranks(:one)
    @rank2 = ranks(:two)
    @rank3 = ranks(:three)
    @rank1 = ranks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ranks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rank" do
    assert_difference('Rank.count') do
      post :create, rank: { name: @rank.name, score_from: @rank.score_from, score_to: @rank.score_to }
    end

    assert_redirected_to rank_path(assigns(:rank))
  end

  test "should show rank" do
    get :show, id: @rank
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rank
    assert_response :success
  end

  test "should update rank" do
    patch :update, id: @rank, rank: { name: @rank.name, score_from: @rank.score_from, score_to: @rank.score_to }
    assert_redirected_to rank_path(assigns(:rank))
  end

  test "should destroy rank" do
    assert_difference('Rank.count', -1) do
      delete :destroy, id: @rank
    end

    assert_redirected_to ranks_path
  end

  test "score_from has to be lower than score_to" do

    assert_no_difference('Rank.count') do
      post :create, rank: { name: @rank.name, score_from: 3.4, score_to: 2.1 }
    end

  end

  test "scores cannot overlap with other Ranks" do
    post :create, rank: { name: @rank1.name, score_from: 1.1, score_to: 5.7 }
    assert_no_difference('Rank.count') do
      post :create, rank: { name: @rank2.name, score_from: 2.4, score_to: 6.1 }
    end
  end
end
