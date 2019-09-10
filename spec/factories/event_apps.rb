FactoryBot.define do
  factory :event_app do
    association :event
    association :user
  end
end