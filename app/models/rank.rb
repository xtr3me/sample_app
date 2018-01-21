class Rank < ActiveRecord::Base

  validates :score_from, presence: true
  validates :score_to, presence: true

# attr_accessor :score_from, :score_to
#
#   def initialize(score_from, score_to)
#     @score_from = score_from
#     @score_to = score_to
#   end

  # def float_one_decimal_score_from
  #   self.score_from.round(1)
  # end
  #
  # def float_one_decimal_score_to
  #   self.score_to.round(1)
  # end

  def float_one_decimal(score_from, score_to)
    self.score_from.round(1)
    self.score_to.round(1)
  end

  # def score_from_lower_than_score_to
  #   if @score_from >= @score_to
  #     puts @score_from
  #   else
  #     flash[:alert] = "Enter a lower number!"
  #   end
  # end
  #
  # def score_to_higher_than_score_from
  #   if @score_to >= @score_from
  #     puts @score_from
  #   else
  #     flash[:alert] = "Enter a higher number!"
  #   end
  # end
  #
  # def new_ranks(score_from, score_to)
  #   if score_from == Rank.new.score_from
  #     flash[:alert] = "This rank has already been set"
  #     redirect_to @rank
  #   elsif score_to == Rank.new.score_to
  #     flash[:alert] = "This rank has already been set"
  #     redirect_to @rank
  #   else
  #     render :new
  #   end
  # end

end
