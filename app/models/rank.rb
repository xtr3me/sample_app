class Rank < ActiveRecord::Base
  validates :name, presence: true
  validates :score_from, presence: true, numericality: { less_than: :score_to, message: 'bad value' }, if: ->(this) { !this.score_to.nil?}
  validates :score_to, presence: true, numericality: { message: 'bad value' }
  validate :check_rank_overlapping

  private

  def check_rank_overlapping
    if score_included_in_another_rank?(score_from) || score_included_in_another_rank?(score_to)
      errors.add(:overlapping, 'overlaps another rank')
      false
    end

    true
  end

  def score_included_in_another_rank?(score)
    Rank.where('? >= score_from AND ? <= score_to', score, score)
  end
end
