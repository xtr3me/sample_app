class Rank < ActiveRecord::Base
  validates :name, :score_from, :score_to, presence: true

end
