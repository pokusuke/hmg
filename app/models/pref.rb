class Pref < ApplicationRecord
  # モデルの関連
  belongs_to :area, foreign_key: 'area_id'

  # バリデーション
  validates :pref_id, presence: true, length: { maximum: 3 }, uniqueness: { case_sensitive: false }
  validates :pref_name, presence: true, length: { maximum: 50 }
end
