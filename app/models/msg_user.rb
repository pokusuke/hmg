class MsgUser < ApplicationRecord
  belongs_to :user
  belongs_to :relation, :class_name => 'User'
  attr_accessor :room_id
  def room_id
    if self.user_id < self.relation_id
      return self.user_id.to_s + "-" + self.relation_id.to_s
    else
      return self.relation_id.to_s + "-" + self.user_id.to_s
    end
  end
end
