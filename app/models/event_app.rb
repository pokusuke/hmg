class EventApp < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :stores
end
