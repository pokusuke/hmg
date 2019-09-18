FactoryBot.define do
  factory :msg do
    msg { 'test message' }
    association :sender
    association :reciever
  end
end
