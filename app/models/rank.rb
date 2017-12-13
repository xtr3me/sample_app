class Rank < ActiveRecord::Base
  validates :name, presence: true
  validates_numericality_of :score_from, :greater_than => 0, :allow_blank => false
  validates_numericality_of :score_to, :greater_than => 0, :allow_blank => false
  validates_numericality_of :score_from, :less_than => :score_to, :if => Proc.new { |o| !o.score_to.nil? } ,
  :message => "can't be greater than retail score_to."

  validates :score_from, :presence => true, :number_precision => true
  validates :score_to, :presence => true, :number_precision => true
  validate :no_overlap_with_other_ranks

  private

  def no_overlap_with_other_ranks
    rank = Rank
    .where("score_from <= :score_to AND score_to >= :score_from", {score_from: score_from, score_to: score_to })
    .where.not(id: id)
    .exists?
    errors.add(:base, "scores cannot overlap with other Ranks") if rank
  end
end
