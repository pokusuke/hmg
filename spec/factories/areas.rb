FactoryBot.define do
  factory :area do
    sequence(:area_name) { |n| "area #{n}" }
  end
end
