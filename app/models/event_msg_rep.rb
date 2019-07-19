class EventMsgRep < ApplicationRecord
  belongs_to :event_msg
  belongs_to :user, :foreign_key => "rep_user_id"
end
