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
    all.map{ |rank| rank.range }
  end

  private

  # Compares score_from and score_to
  # and return error if it's agains validtion rules
  def validate_scores
    errors.add(:score_from, 'has to be lower than score_to') if (score_from <=> score_to) > 0
  end

  # It will return error if it's overlappimg
  def not_overlapping
    Rank.ranges.each do |range|
      errors.add(:score, 'should not overlap with other records') if range.include?(score_from) || range.include?(score_to)
      return
    end
  end
end
