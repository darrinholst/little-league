FactoryGirl.define do
  factory :team do
    name 'some name'
    division {FactoryGirl.build(:division)}
  end
end
