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
end
