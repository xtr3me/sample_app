FactoryBot.define do
  factory :rank do
    name { 'Rank name' }
    score_from { (0..100).to_a.sample }
    score_to { (0..100).to_a.sample }
  end
end
