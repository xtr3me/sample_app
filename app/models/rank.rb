class Rank < ActiveRecord::Base
  validates :name, presence: true
  validate :score_from_lower_than_score_to?
  validate :score_to_greater_than_score_from?
  validate :overlap_rank_instance?

	def score_from_lower_than_score_to?
		if score_from < score_to
			errors.add(:base, 'score_from can\'t be higher than score_to')
		end
	end

	def score_to_greater_than_score_from?
		if score_to > score_from
			errors.add(:base, 'score_to can\'t be lower than score_from')
		end
	end

	def overlap_rank_instance?
		
		Rank.all.each do |rank|
			if 	(score_from..score_to).overlaps?(rank.score_from..rank.score_to)
				errors.add(:base, 'value overlap is not prohibited')
			end
		end
	end
end
