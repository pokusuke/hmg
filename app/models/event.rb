class Event < ApplicationRecord
  # モデルの関連定義
  belongs_to :user, :foreign_key => "user_id"
  belongs_to :pref, :foreign_key => "pref_id"
  has_many :event_apps

  # バリデーション
  validates :event_name, presence:true, length:{ maximum: 255 }
  validates :event_date, presence:true
  validates :event_published_flg, presence:true
  validates :event_detail,length:{ maximum: 2000 }
  validates :city, length:{ maximum: 255 }
  validates :place_detail, length:{ maximum: 255 }
  validates :event_recruiting_flg, presence:true
  validates :event_recruit_number, numericality: { only_integer: true, greater_than_or_equal_to: 0},allow_nil: true
  validates :event_entrance_fee, numericality: { only_integer: true, greater_than_or_equal_to: 0},allow_nil: true
  validate :valid_date

  # カスタムのバリデーションメソッド
  def valid_date
    if event_recruit_start_date.present?
      if event_recruit_end_date.present?
        if event_recruit_start_date > event_recruit_end_date
          errors.add(:event_recruit_start_date, "は募集終了日より前の日付で指定してください")
        end
      end
    end
  end

  # ファイルアップロード
  mount_uploader :photo_url1, AvatarUploader
  mount_uploader :photo_url2, AvatarUploader
  mount_uploader :photo_url3, AvatarUploader
  mount_uploader :photo_url4, AvatarUploader

  # 区分値
  enum event_recruiting_flgs: {"募集しない" => 0, "募集する" => 1}
  enum event_published_flgs: {"下書き" => 0 ,"公開" => 1 }

  # クエリ
  scope :search_with_pref, ->(pref_id) { where(pref_id: pref_id) }
  scope :search_with_start, ->(event_date_from){ where("event_date >= ?",event_date_from) }
  scope :search_with_end, ->(event_date_to){ where("event_date <= ?",event_date_to)}

  
end
