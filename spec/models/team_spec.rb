require 'spec_helper'

describe Team do
  before :each do
    @braves = create(:team, name: 'Perry 1 Braves')
    @royals = create(:team, name: 'Royals')
    @cubs = create(:team, name: 'Cubs')
  end

  it 'should find all rookie teams' do
    @braves.division = @cubs.division = create(:division, name: 'Rookies')
    @braves.save!
    @cubs.save!

    rookie_teams = Team.in_division(:rookies)

    rookie_teams.size.should == 2
    rookie_teams.should include @braves
    rookie_teams.should include @cubs
  end

  it 'should find a team by a matching name' do
    Team.name_matches('perry%braves').should == @braves
  end

  it 'should not find a matching name if not there' do
    Team.name_matches('foo%bar').should == nil
  end
end

