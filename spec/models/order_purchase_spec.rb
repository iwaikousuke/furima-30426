require 'rails_helper'

RSpec.describe OrderPurchase, type: :model do
  before do
    user1 = FactoryBot.create(:user)
    item1 = FactoryBot.create(:item)
    @order_purchase = FactoryBot.build(:order_purchase, user_id: user1.id, item_id: item1.id)
    sleep(1)
  end

  describe '商品購入機能について' do
    context '商品が購入出来る時' do
      it 'token, postal_code, prefecture_id, city, street_address, phone_number,user_id,item_idが存在すれば登録できる' do
        expect(@order_purchase).to be_valid
      end
    end

    context '商品が購入出来ない時' do
      it 'tokenが空の時' do
        @order_purchase.token = ''
        @order_purchase.valid?
        expect(@order_purchase.errors.full_messages).to include("クレジットカード情報を入力してください")
      end

      it 'postal_codeがハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_purchase.postal_code = 134567
        @order_purchase.valid?
        expect(@order_purchase.errors.full_messages).to include("郵便番号ハイフンを入れて入力してください")
      end

      it 'postal_codeが空の時' do
        @order_purchase.postal_code = ''
        @order_purchase.valid?
        expect(@order_purchase.errors.full_messages).to include("郵便番号を入力してください", "郵便番号ハイフンを入れて入力してください")
      end

      it 'prefecture_idが1の時' do
        @order_purchase.prefecture_id = 1
        @order_purchase.valid?
        expect(@order_purchase.errors.full_messages).to include("都道府県を選択してください")
      end

      it 'cityが空では保存出来ない時' do
        @order_purchase.city = ''
        @order_purchase.valid?
        expect(@order_purchase.errors.full_messages).to include("市区町村を入力してください")
      end

      it 'street_addressが空では保存出来ない時' do
        @order_purchase.street_address = ''
        @order_purchase.valid?
        expect(@order_purchase.errors.full_messages).to include("番地を入力してください")
      end

      it 'phone_numberが空では登録できない時' do
        @order_purchase.phone_number = ''
        @order_purchase.valid?
        expect(@order_purchase.errors.full_messages).to include("電話番号を入力してください", "電話番号ハイフンは除いて入力してください")
      end

      it 'phone_numberにハイフンを含んだ間違った形式では保存できないこと' do
        @order_purchase.phone_number = '090-1234-5678'
        @order_purchase.valid?
        expect(@order_purchase.errors.full_messages).to include("電話番号ハイフンは除いて入力してください")
      end

      it 'phone_numberが11桁以上の場合' do
        @order_purchase.phone_number = '090123456789'
        @order_purchase.valid?
        expect(@order_purchase.errors.full_messages).to include("電話番号ハイフンは除いて入力してください")
      end

      it 'phone_numberが11桁未満の場合' do
        @order_purchase.phone_number = '0901234567'
        @order_purchase.valid?
        expect(@order_purchase.errors.full_messages).to include("電話番号ハイフンは除いて入力してください")
      end
    end
  end
end
