class Rank < ActiveRecord::Base
  validates :name, presence: true
  validate :ensure_to_from_higher, :ensure_no_overlap

  private
  def ensure_to_from_higher
    to, from = self.score_to.round(1), self.score_from.round(1)
    unless to > from && from < to && from != to
      self.errors[:base] << "'Score To' must be higher than 'Score From'"
    end
  end

  private
  def ensure_no_overlap
    master_range = rank_to_range(self)
    Rank.all.each do |lr|
      if rank_to_range(lr).overlaps?(master_range)
        self.errors[:base] << "Score range overlaps with other score range."
        break
      end
    end
  end

  private
  def rank_to_range(rank)
    (rank.score_from..rank.score_to)
  end

end
