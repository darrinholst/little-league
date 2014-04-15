require 'spec_helper'

describe Game do
  let(:game) {build(:game)}

  before(:each) do
    game.should be_valid
  end

  it "should parse start time" do
    game.starts_at = "05/15/2011 08:00 pm"
    game.starts_at_display.should == "Sun May 15 8:00 PM"
  end

  it "should require home team" do
    game.home_team = nil
    should_be_invalid "Home team can't be blank"
  end

  it "should require home team" do
    game.visiting_team = nil
    should_be_invalid "Visiting team can't be blank"
  end

  it "should require teams to be part of the same division" do
    game.visiting_team = build(:team, division: build(:division, name: 'rookies'))
    game.home_team = build(:team, division: build(:division, name: 'minors'))
    should_be_invalid "Teams must be in the same division"
  end

  def should_be_invalid(message)
    game.should_not be_valid
    game.errors.full_messages.join(" ").should == message
  end

  it 'should find all rookie games' do
    rookies = create(:division, name: 'Rookies')
    minors = create(:division, name: 'Minors')

    rookies_game = create(:game, home_team: create(:team, division: rookies), visiting_team: create(:team, division: rookies))
    minors_game = create(:game, home_team: create(:team, division: minors), visiting_team: create(:team, division: minors))

    rookies_games = Game.in_division('rookies')

    rookies_games.size.should == 1
    rookies_games.should include rookies_game
  end

  it 'should tell if a game does not include a local team' do
    game.includes_local_team?.should be_false
  end

  it 'should tell if a games home team is local' do
    game.home_team.local = true
    game.includes_local_team?.should be_true
  end

  it 'should tell if a games visiting team is local' do
    game.visiting_team.local = true
    game.includes_local_team?.should be_true
  end
end
