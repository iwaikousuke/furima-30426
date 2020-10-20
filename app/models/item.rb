class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :shopping
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :day
  belongs_to :user
  has_one_attached :image
  has_one :purchase

  validates :image, :name, :text, :category, :status, :shopping, :prefecture, :day, :price, presence: true

  validates :category_id, :status_id, :shopping_id, :prefecture_id, :day_id, numericality: { other_than: 1 }

  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: '300~9999999' }
end
