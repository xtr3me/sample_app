class Rank < ActiveRecord::Base
  validates :name, presence: true
  validates_numericality_of :score_to, :greater_than => :score_from
  validate :no_score_from_overlap
  validates :score_from, presence: true, format: { with: /\A\d+(?:\.\d{1})?\z/ }
  validates :score_to, presence: true, format: { with: /\A\d+(?:\.\d{1})?\z/ }

  private

  def no_score_from_overlap
    if (Rank.where("(? BETWEEN score_from AND score_to OR ? BETWEEN score_from AND score_to)", self.score_from, self.score_to).any?)
       errors.add(:date_end, 'it overlaps another reservation')
    end
  end
end
