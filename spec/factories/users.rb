FactoryBot.define do
  factory :user do
    name { "Test" }
    nick_name { "T" }
    sequence(:email) { |n| "tester#{n}@example.com"}
    password { "hogehoge" } 
  end
end