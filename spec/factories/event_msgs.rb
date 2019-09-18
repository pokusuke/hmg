FactoryBot.define do
  factory :event_msg do
    msg { 'test message' }
    association :event
    association :user
  end
end
