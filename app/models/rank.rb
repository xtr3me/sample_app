class Rank < ActiveRecord::Base
  before_save :round
  validates :name, presence: true
  validates_numericality_of :score_from
  validates_numericality_of :score_to, greater_than: :score_from
  validate :do_not_overlap_with_others

  def do_not_overlap_with_others
    unless Rank.where("score_from < ? AND score_to => ?", score_from, score_from) || Rank.where("score_from =< ? AND score_to => ?", score_to, score_to)
      return false
    end
  end

  def round
    self.score_from = score_from.round(1)
    self.score_to = score_to.round(1)
  end
end
