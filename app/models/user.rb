class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  TEXT_REGEX = /\A[ぁ-んァ-ン一-龥]/
  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'is invalid. Input full-width characters.' } do
    validates :last_name
    validates :first_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters.' }do
    validates :last_name_kana
    validates :first_name_kana
  end

  with_options presence: true do
    validates :nickname
    validates :birth_date
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[\w-]{6,128}+\z/i, message: ' Include both letters and numbers.' }
  end
end
