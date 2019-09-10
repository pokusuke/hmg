class EventApp < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :stores

  validates_uniqueness_of :user_id, scope: :event_id
end
