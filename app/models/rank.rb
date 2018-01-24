class Rank < ActiveRecord::Base
  validates :score_from, presence: true
  validates :score_to, presence: true

  validate :score_to_higher_than_score_from,
           :score_from_lower_than_score_to

  before_save :float_one_decimal

  def float_one_decimal
    self.score_from = score_from.round(1)
    self.score_to = score_to.round(1)
  end

  def score_to_higher_than_score_from
    if self.score_to < self.score_from
      errors.add(:score_to, 'should be higher than score from' )
    end
  end

  def score_from_lower_than_score_to
    if self.score_from > self.score_to
      errors.add(:score_from, 'should be lower than score to ')
    end
  end

  def rank_search_scores
    rank_match = Rank.where({self.score_from => search_score })
    if rank_match.empty?
      return nil
      else
        return rank_match
    end
  end


end
