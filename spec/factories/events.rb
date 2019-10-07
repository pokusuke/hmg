FactoryBot.define do
  factory :event do
    sequence(:event_name) { |n| "Event #{n}" }
    event_date { 1.week.from_now }
    event_published_flg { 1 }
    event_recruiting_flg { 1 }
    city { 'test' }
    place_detail { 'sample city' }
    event_detail { 'sample event' }
    event_recruit_start_date { 1.day.from_now }
    event_recruit_end_date { nil }
    event_recruit_number { 10 }
    event_entrance_fee { 3000 }
    photo_url1 { 'test.com' }
    association :user
    association :pref
    # 本日のイベント
    trait :event_today do
      event_name { 'Event Today' }
      event_date { Date.current.in_time_zone }
    end    
  end
end
