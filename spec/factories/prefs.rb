FactoryBot.define do
  factory :pref do
    sequence(:pref_id, &:to_s)
    pref_name { 'test pref' }
    association :area
  end
end
