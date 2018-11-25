class Rank < ActiveRecord::Base
  validates :name, presence: true
  validates :score_to, presence: true, numericality: {only_decimal: true}
  validates :score_from, presence: true, numericality: {only_decimal: true}
 	validates_numericality_of :score_to, greater_than: :score_from
 	after_save :rounding


  def rounding
   	self.score_to = score_to.round(1)	
   	self.score_from = score_from.round(1)
  end
end
