require 'rails_helper'

describe Rank, type: :model do
  # validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:score_from) }
  it { should validate_presence_of(:score_to) }


end