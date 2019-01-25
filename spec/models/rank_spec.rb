require 'rails_helper'

describe Rank, type: :model do
  # validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:score_from) }
  it { should validate_presence_of(:score_to) }

  describe '#validate_scores' do
    it 'should give an error if score_from is greather than score_to' do
      rank = FactoryBot.create(:rank, score_from: 5, score_to: 2)
      expect(rank).not_to be_valid
    end

    it 'should return error if score_to is lower than score_from' do
      rank = FactoryBot.create(:rank, score_from: 5, score_to: 2)
      expect(rank).not_to be_valid
    end
  end
end