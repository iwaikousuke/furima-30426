class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_many :items
  has_many :sns_credentials

  def self.from_omniauth(auth)
      sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
      user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
         email: auth.info.email
     )

    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end

  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: '全角で入力してください' } do
    validates :last_name
    validates :first_name
    validates :nickname
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: '全角カタカナで入力してください' } do
    validates :last_name_kana
    validates :first_name_kana
  end

  with_options presence: true do
    validates :nickname
    validates :birth_date
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[\w-]{6,128}+\z/i, message: ' 半角英数字混同で入力してください' }
  end
end
