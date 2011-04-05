require 'spec_helper'

describe Game do
  let(:game) {new_game}

  before(:each) do
    game.should be_valid
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
    game.visiting_team = new_team(:division => new_division(:name => "rookies"))
    game.home_team = new_team(:division => new_division(:name => "minors"))
    should_be_invalid "Teams must be in the same division"
  end

  def should_be_invalid(message)
    game.should_not be_valid
    game.errors.full_messages.join(" ").should == message
  end
end
