require 'rails_helper'

RSpec.describe Rank, type: :model do

  before(:each) do
    rank = Rank.create({ name: 'test' })
    @data = get_data_from_file  # [ '42', '36' ]
  end


  it 'score_from < score_to' do
    
    rank.score_from = 3
    rank.score_to = 5
    expect(rank).to be_valid
  end

  # it 'should should throw error' do
  #   rank = Rank.create({ name: 'test', score_from: 3, score_to: 5 })
  #   expect(rank).to be_valid
  # end

  # it 'score_to > score_to' do
  #   # checker = rank.score_from > rank.score_to
  #   expect(rank.score_to).to be > rank.score_from
  # end
end
