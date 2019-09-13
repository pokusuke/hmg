class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable

  has_many :events, dependent: :destroy
  mount_uploader :avatar_path, AvatarUploader

  ###バリデーション
  ##email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,presence:true,length:{maximum:255},
            format:{with:VALID_EMAIL_REGEX},
            uniqueness:{case_sensitive: false}
  validates :name, presence:true

  ##パスワード
  #has_secure_password
  validates :password,presence:true,length:{minimum:6},allow_nil:true

  #渡されたトークンがダイジェスト一致したらtrueを返す
  def authenticated?(attribute,token)
    digest = send("#{attribute}_digest")
    return if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
end
