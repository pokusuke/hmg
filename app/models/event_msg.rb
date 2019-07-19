class EventMsg < ApplicationRecord
  belongs_to :event
  belongs_to :user, :foreign_key => "sender_id"
end
