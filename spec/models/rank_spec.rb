require 'rails_helper'

RSpec.describe Rank, type: :model do

  rank = Rank.create({ name: 'test' })
  rank.score_from = 1
  rank.score_to = 2

  it 'score_from < score_to' do
   rank = Rank.create!({name:'test',score_from:3,score_to:5})
    expect(rank.score_from).to be < rank.score_to
  end

  it 'should should throw error' do 
    rank =Rank.create!({name:'test',score_from:3,score_to:5})
    if rank.score_to < rank.score_from
      raise "oops"
    end
  end

  # it 'score_to > score_to' do
  #   # checker = rank.score_from > rank.score_to
  #   expect(rank.score_to).to be > rank.score_from
  # end
end
