FactoryGirl.define do
  factory :game do
    starts_at 'tomorrow'
    field FactoryGirl.build(:field)
    home_team {FactoryGirl.build(:team)}
    visiting_team {FactoryGirl.build(:team)}
  end
end
