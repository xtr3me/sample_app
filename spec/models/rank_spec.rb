require 'rails_helper'

RSpec.describe Rank do
  context 'score_from should be less than score_to:' do
    it 'fails when score_from is missing' do
        rank = Rank.new(name: 'Name1', score_from: nil, score_to: 1.34)
        expect(rank.valid?).to be false
    end

    it 'fails when score_to is missing' do
        rank = Rank.new(name: 'Name1', score_from: 1.23, score_to: nil)
        expect(rank.valid?).to be false
    end

    it 'fails when score_from is greater than score_to' do
        rank = Rank.new(name: 'Name1', score_from: 1.45, score_to: 1.34)
        expect(rank.valid?).to be false
        expect(rank.errors[:score_from]).to include('bad value')
    end

    it 'fails when score_from is equal to score_to' do
        rank = Rank.new(name: 'Name1', score_from: 1.45, score_to: 1.45)
        expect(rank.valid?).to be false
        expect(rank.errors[:score_from]).to include('bad value')
    end

    it 'succeeds when score_from is less than score_to' do
        rank = Rank.new(name: 'Name1', score_from: 1.23, score_to: 1.34)
        expect(rank.valid?).to be true
    end
  end

  context 'score should not overlap with other scores:' do
    rank1 = Rank.create(name: 'Name1', score_from: 1.1, score_to: 5.45)
    rank2 = Rank.create(name: 'Name2', score_from: 7, score_to: 9)

    it 'fails when a new rank has a score inside other ranks segments' do
        rank = Rank.new(name: 'Name3', score_from: 1.23, score_to: 6.34)
        expect(rank.valid?).to be false
        expect(rank.errors[:overlapping]).to include('overlaps')
    end

    it 'succeeds when a new rank has a score outside other ranks segments' do
        rank = Rank.new(name: 'Name3', score_from: 5.55, score_to: 5.75)
        expect(rank.valid?).to be true
    end
  end
end
