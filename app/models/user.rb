class User < ApplicationRecord
  has_many :events
  mount_uploader :avatar_path, AvatarUploader
end
