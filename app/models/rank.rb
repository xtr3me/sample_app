class Rank < ActiveRecord::Base
  validates :name, :score_from, :score_to, presence: true
  validate :validate_scores
  validate :not_overlapping

  # Returns instance's score_from and score_to as a range
  def range
    (score_from..score_to)
  end

  # Maps the records as ranges
  def self.ranges
    all.map(&:range)
  end

  private

  # Compares score_from and score_to
  # and returns error if it's against validation rules
  def validate_scores
    errors.add(:score_from, 'has to be lower than score_to') if (score_from <=> score_to) > 0
  end

  # It will return error if it's overlappimg
  def not_overlapping
    Rank.ranges.each do |range|
      if range.include?(score_from) || range.include?(score_to)
        errors.add(:score, 'should not overlap with other records')
        return
      end
    end
  end
end
