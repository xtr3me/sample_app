class Rank < ActiveRecord::Base
  validates :name, presence: true
  validates :score_to, numericality: { greater_than: :score_from}
  validates :score_from, numericality: { less_than: :score_to}
  validate :no_conflict_ranks

  def no_conflict_ranks
    if Rank.where("score_from <= ? AND score_to >= ?", score_to, score_to).present? || Rank.where("score_from <= ? AND score_to >= ?", score_from, score_from).present?
      errors.add(:score_from, "This rank is already used, pick another one")
    end
  end

end
