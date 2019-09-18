FactoryBot.define do
  factory :store do
    name  { 'sample store' }
    store_desc  { 'sample store desc' }
    association :user
    association :event_app
    event_id { event_app.event_id }
  end
end
