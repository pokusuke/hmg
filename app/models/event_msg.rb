class EventMsg < ApplicationRecord
  # モデルの関連
  belongs_to :event
  belongs_to :user, :foreign_key => "sender_id"
  has_many :event_msg_reps

  # バリデーション
  validates :msg,  length:{ maximum: 400 }

end
