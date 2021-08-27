class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  with_options presence: true do
    validates :email
    validates :name
    validates :phone_number
  end

  validates :phone_number, format: {with: /\A[0-9]{10,11}\z/, message: "は10桁もしくは11桁で記入してください" }

  attachment :user_image

  # フォローされているユーザーに関するアソシエーション
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :following

  # フォローしているユーザーに関するアソシエーション
  has_many :relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  # ダイレクトメッセージに関するアソシエーション
  has_many :entries,  dependent: :destroy
  has_many :messages, dependent: :destroy

  # 投稿に関するアソシエーション
  has_many :posts,          dependent: :destroy
  has_many :post_favorites, dependent: :destroy
  has_many :post_contents,  through:   :post_favorites, source: :post
  has_many :post_comments,  dependent: :destroy

  # バスケ施設に関するアソシエーション
  has_many :facility_favorites, dependent: :destroy
  has_many :post_facilities,    through:   :facility_favorites, source: :facility
  has_many :facility_comments,  dependent: :destroy
  has_many :reserve_facilities

  has_many :sns_credentials, dependent: :destroy

  # フォローする
  def follow(user_id)
    relationships.create!(followed_id: user_id)
  end

  # フォローを外す
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  # フォローしているか確認
  def following?(user)
    followings.include?(user)
  end

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    sns_credential_record = SnsCredential.where(provider: auth.provider, uid: auth.uid)
    if user.present?
      unless sns_credential_record.present?
        SnsCredential.create(
          user_id: user.id,
          provider: auth.provider,
          uid: auth.uid
        )
      end
      return user
    end
  end

  def self.search(search)
    return User.where('name LIKE(?)', "#{search}%")
  end
end
