require 'spec_helper'

describe Field do
  before :each do
    @perry_major = create(:field, name: 'Perry Major')
    @ogden = create(:field, name: 'Ogden')
  end

  it 'should find a field by a matching name' do
    Field.name_matches('perry major').should == @perry_major
  end

  it 'should not find a matching name if not there' do
    Field.name_matches('foo bar').should == nil
  end
end

