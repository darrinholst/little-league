FactoryGirl.define do
  factory :team do
    division {FactoryGirl.build(:division)}
  end
end
