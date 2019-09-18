FactoryBot.define do
  factory :user, aliases: %i[sender reciever] do
    name { 'Test' }
    nick_name { 'T' }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'hogehoge' }
    confirmed_at { Date.current.in_time_zone }
  end
end
