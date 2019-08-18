class Event < ApplicationRecord
  belongs_to :user, :foreign_key => "user_id"
  belongs_to :pref, :foreign_key => "pref_id"
  has_many :event_apps
  mount_uploader :photo_url1, AvatarUploader
  mount_uploader :photo_url2, AvatarUploader
  mount_uploader :photo_url3, AvatarUploader
  mount_uploader :photo_url4, AvatarUploader

  enum event_recruiting_flgs: {"募集しない" => 0, "募集する" => 1}
  enum event_published_flgs: {"下書き" => 0 ,"公開" => 1 }

  scope :search_with_pref, ->(pref_id) { where(pref_id: pref_id) }
  scope :search_with_start, ->(event_date_from){ where("event_date >= ?",event_date_from) }
  scope :search_with_end, ->(event_date_to){ where("event_date <= ?",event_date_to)}
end
