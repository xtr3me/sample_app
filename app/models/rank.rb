class Rank < ActiveRecord::Base
  validates :score_from, presence: true
  validates :score_to, presence: true

  before_save :float_one_decimal
  before_save :score_to_higher_than_score_from
  
  def float_one_decimal
    self.score_from = score_from.round(1)
    self.score_to = score_to.round(1)
  end

  def score_to_higher_than_score_from
    if self.score_to >= self.score_from
      puts score_from
      else
        'Enter higher "Score to" number'
    end

  end
  #
  # def score_from_lower_than_score_to
  #   if self.score_from >= self.score_to
  #     puts score_to
  #   end
  # end


  def new_ranks(score_from, score_to)
    if score_from == Rank.new.score_from
       "This rank has already been set"
      redirect_to @rank
    elsif score_to == Rank.new.score_to
       "This rank has already been set"
      redirect_to @rank
    else
      # do something else
    end
  end

end
