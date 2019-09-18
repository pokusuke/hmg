FactoryBot.define do
  factory :event_msg_rep do
    msg { 'test message' }
    association :event_msg
    association :user
  end
end
