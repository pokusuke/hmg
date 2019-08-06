class Msg < ApplicationRecord
  belongs_to :sender, :class_name => 'User'
  belongs_to :reciever, :class_name => 'User'
  mount_uploader :photo_url, AvatarUploader
end
