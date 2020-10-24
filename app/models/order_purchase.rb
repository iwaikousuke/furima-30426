class OrderPurchase
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :street_address, :phone_number, :building, :user_id, :item_id, :purchase_id, :token

  # tokenについてのバリデーション
  validates :token, presence: true

  # 配送先に関するバリデーション（建物名は任意なので除く）
  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: 'input correctly,Include hyphen(-).' }
    validates :phone_number, format: { with: /\A\d{11}\z/, message: 'input only number.' }
  end

  validates :city, :street_address, presence: true

  # 配送先（都道府県）のバリデーションについて
  validates :prefecture_id, numericality: { other_than: 1 }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, street_address: street_address, phone_number: phone_number, building: building, purchase_id: purchase.id)
  end
end
