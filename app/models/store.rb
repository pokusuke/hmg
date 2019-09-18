class Store < ApplicationRecord
  belongs_to :event_app, foreign_key: 'event_app_id'
  belongs_to :user, foreign_key: 'store_owner_id'

  validates :name, presence: true
  validates :store_desc, length: { maximum: 2000 }
end
