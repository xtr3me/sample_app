class Rank < ActiveRecord::Base
  validates :name, presence: true

  validates :score_to, numericality: { greater_than: :score_from}
  validates :score_to, format: /\A\d+\.*\d{0,1}\Z/
  validates :score_from, format: /\A\d+\.*\d{0,1}\Z/

  validate :score_ranges

  private

  def score_ranges
    scores = Rank.order(:score_from).where.not(id: id).pluck(:score_from, :score_to)
    scores.each do |score|
      check_score_valid(score)
    end
  end

  def check_score_valid(score)
    errors.add(:score_from, 'overlaps with another range on system') if score_from_invalid?(score)
    errors.add(:score_to, 'overlaps with another range on system') if score_to_invalid?(score)
  end

  def score_from_invalid?(score)
    if score_from.between?(score[0], score[1])
      return true
    elsif score[0].between?(score_from, score_to)
      return true
    end
    false
  end

  def score_to_invalid?(score)
    if score_to.between?(score[0], score[1])
      return true
    elsif score[1].between?(score_from, score_to)
      return true
    end
    false
  end
end
