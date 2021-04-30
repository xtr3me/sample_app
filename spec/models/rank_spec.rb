require 'rails_helper'

RSpec.describe Rank, type: :model do

  context  'validates score_from has to be lower than score_to' do
    it 'with valid score_from' do
      expect(Rank.new(score_from: 1, score_to: 2, name: 'rank-1')).to be_valid
    end

    it 'with not valid score_from' do
      expect(Rank.new(score_from: 3, score_to: 2, name: 'rank-1')).to_not be_valid
    end

    it 'when equal attributes' do
      expect(Rank.new(score_from: 1, score_to: 1, name: 'rank-1')).to_not be_valid
    end
  end

  context 'test overloap attributes' do
    it 'should not be saved when overlap' do
      Rank.create!(score_from: 1, score_to: 3, name: 'rank-1')

      expect {
        Rank.create(score_from: 2, score_to: 3, name: 'rank-2')
      }.to_not change { Rank.count }
    end

    it 'should not be saved with equal attributes' do
      Rank.create!(score_from: 1, score_to: 3, name: 'rank-1')

      expect {
        Rank.create(score_from: 1, score_to: 3, name: 'rank-2')
      }.to_not change { Rank.count }
    end
  end

  context 'scores have a precision of one' do
    it 'when precision of one should be valid' do
      expect(Rank.new(score_from: 1.1, score_to: 2.2, name: 'rank-1')).to be_valid
    end

    it 'when precision is higher than one should not be valid' do
      expect(Rank.new(score_from: 1.123, score_to: 2.233, name: 'rank-1')).to_not be_valid
    end
  end
end
