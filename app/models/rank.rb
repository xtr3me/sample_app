class Rank < ActiveRecord::Base
  validates :name, presence: true

  validate :validate_scores_are_ordered_for_a_rank

  private

  def validate_scores_are_ordered_for_a_rank
    unless score_from < score_to
      errors.add(:score_from, 'must be lower than score_to')
      errors.add(:score_to, 'must be higher than score_from')
    end
  end
end
