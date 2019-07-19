class MsgUser < ApplicationRecord
  belongs_to :user
  belongs_to :relation, :class_name => 'User'
end
