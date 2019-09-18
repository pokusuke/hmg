class Area < ApplicationRecord
  # モデルの関連
  has_many :prefs

  # バリデーション
  validates :area_name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
end
