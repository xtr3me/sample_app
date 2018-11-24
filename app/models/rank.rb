class Rank < ActiveRecord::Base
  validates :name, presence: true
  validates_numericality_of :score_to, greater_than: :score_from
  validate :check_range
  validate :check_decimal

	def check_range
	    score_to_inrange = Rank.where("score_to >= ? AND score_from <= ?", score_to, score_to).first()
	    score_from_inrange = Rank.where("score_to >= ? AND score_from <= ?", score_from, score_from).first()
	    unless score_to_inrange.nil? && score_from_inrange.nil?
	      errors.add(:base,"There is already a rank set for this score")
	    end
	end

	def check_decimal
		decimals = 1;
		score_to_check = score_to * 10 * decimals;
		score_from_check = score_from * 10 * decimals;
		if (score_to_check % 1 != 0) || (score_from_check % 1 != 0)
			errors.add(:base,"Scores need to have #{decimals} decimal places.")
		end
	end
end
