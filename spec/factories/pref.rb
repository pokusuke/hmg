FactoryBot.define do
  factory :pref do
    sequence(:pref_id) { |n| "#{n}" }
    pref_name { "test pref" }
    association :area
  end
end