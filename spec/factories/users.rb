FactoryBot.define do
  factory :user, aliases: [:sender,:reciever] do
    name { "Test" }
    nick_name { "T" }
    sequence(:email) { |n| "tester#{n}@example.com"}
    password { "hogehoge" } 
  end
end