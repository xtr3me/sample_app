require 'rails_helper'

describe Rank, type: :model do
  # validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:score_from) }
  it { should validate_presence_of(:score_to) }

  describe '#validate_scores' do
    it 'should give an error if score_from is greather than score_to' do
      rank = FactoryBot.build(:rank, score_from: 5, score_to: 2)
      expect(rank).not_to be_valid
    end

    it 'should return error if score_to is lower than score_from' do
      rank = FactoryBot.build(:rank, score_from: 5, score_to: 2)
      expect(rank).not_to be_valid
    end
  end

  describe '#not_overlapping' do
    it 'should not allow creating a record overlapping with others' do
      FactoryBot.create(:rank, score_from: 1, score_to: 10)
      rank = FactoryBot.build(:rank, score_from: 6, score_to: 15)
      expect(rank).not_to be_valid
    end
  end
end