class MsgUser < ApplicationRecord
  belongs_to :user
  belongs_to :relation, class_name: 'User'
  attr_accessor :room_id
  def room_id
    if user_id < relation_id
      user_id.to_s + '-' + relation_id.to_s
    else
      relation_id.to_s + '-' + user_id.to_s
    end
  end
end
