class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: '全角で入力してください' } do
    validates :last_name
    validates :first_name
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
