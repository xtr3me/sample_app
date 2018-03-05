require_relative '../rails_helper'

describe Rank do

  before do
    @error_higher = "'Score To' must be higher than 'Score From'"
    @error_overlap = "Score range overlaps with other score range."
    @ranks = {
        :normal => Rank.new(name: "R1", score_from: 10, score_to: 20),
        :equal => Rank.new(name: "R2", score_from: 10, score_to: 10),
        :reverse => Rank.new(name: "R3", score_from: 20, score_to: 10),
        :round_1 => Rank.new(name: "R4", score_from: 10.2, score_to: 10.24),
        :round_2 => Rank.new(name: "R5", score_from: 10.2, score_to: 10.25),
        :overlap_1 => Rank.new(name: "R6", score_from: 9, score_to: 19),
        :overlap_2 => Rank.new(name: "R7", score_from: 21, score_to: 30),
    }
  end

  context "A new record has top be verified." do

    describe ".ensure_to_from_higher" do
      it "should ensure that score_from is lower than score_to" do
        expect(@ranks[:normal].save).to eq true
        expect(@ranks[:normal].errors[:base].size).to eq 0
        expect(@ranks[:equal].save).to eq false
        expect(@ranks[:equal].errors[:base].size).to be > 0
        expect(@ranks[:reverse].save).to eq false
        expect(@ranks[:reverse].errors[:base].size).to be > 0
      end
    end

  end

end
