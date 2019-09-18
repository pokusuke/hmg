class EventMsgRep < ApplicationRecord
  belongs_to :event_msg
  belongs_to :user, foreign_key: 'rep_user_id'

  # バリデーション
  validates :msg, length: { maximum: 400 }

  mount_uploader :photo_url, AvatarUploader
end
