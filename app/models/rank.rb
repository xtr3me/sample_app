class Rank < ActiveRecord::Base
  validates :score_from, presence: true
  validates :score_to, presence: true

  validate :score_to_higher_than_score_from,
          :score_from_lower_than_score_to

  before_save :float_one_decimal
  before_save :score_to_higher_than_score_from


  def float_one_decimal
    self.score_from = score_from.round(1)
    self.score_to = score_to.round(1)
  end

  def score_to_higher_than_score_from
    if self.score_to < self.score_from
      errors.add(:score_to, 'Enter higher SCORE TO number' )
    end
  end

  def score_from_lower_than_score_to
    if self.score_from > self.score_to
      errors.add(:score_from, 'Enter a lower SCORE FROM number')
    end
  end

  def new_ranks
    if self.score_from == self.score_to
       # "This rank has already been set"
      puts score_from
    else
      return false
    end
  end

end
