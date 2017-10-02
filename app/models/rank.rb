class Rank < ActiveRecord::Base
  validates :name, presence: true

  validate :validate_scores_are_ordered_for_a_rank
  validate :validate_score_ranges_do_not_overlap

  private

  def validate_scores_are_ordered_for_a_rank
    unless score_from < score_to
      errors.add(:score_from, 'must be lower than score_to')
      errors.add(:score_to, 'must be higher than score_from')
    end
  end

  def validate_score_ranges_do_not_overlap
    # Select the existing rank with the highest score_from not greater than our score_to -
    # this is a necessary condition for an overlap (assuming that all existing ranks are non-overlapping already)
    # TODO: ASCII art "timeline"
    highest_other =
      Rank.
        where.not(id: self.id).
        where('score_from <= ?', score_to).
        order(score_from: :desc).
        limit(1)

    highest_other = !highest_other.empty? && highest_other.first

    # The existing rank is indeed overlapping with us if and only if
    # its score_to is higher (or equal) our score_from
    # TODO: ASCII art "timeline"
    if highest_other && highest_other.score_to >= score_from
      errors.add(:base,
                 "Score range (#{score_from} - #{score_to}) must not overlap " +
                 "with score range of #{highest_other.name} (#{highest_other.score_from} - #{highest_other.score_to})")
    end
  end
end
