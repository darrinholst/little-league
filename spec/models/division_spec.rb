require 'spec_helper'

describe Division do
  before :each do
    @rookies = create(:division, name: 'Rookies')
    @minors = create(:division, name: 'Minors')
  end

  it 'should find the rookies division' do
    Division.name_matches(:rookies) == @rookies
  end
end

