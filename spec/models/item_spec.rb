require 'rails_helper'

describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品について' do
    context '商品出品出来る時' do
      it 'name,text,category_id,status_id,shopping_id,prefecture_id,day_id,price,imageが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品出来ない時' do
      it '商品名が空の時' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it 'textが空の時' do
        @item.text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品説明を入力してください")
      end

      it 'category_idが空の時' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選択してください")
      end

      it 'category_idが1の時' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選択してください")
      end

      it 'status_idが空の時' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Statusを入力してください", "商品の状態を選択してください")
      end

      it 'status_idが1の時' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を選択してください")
      end

      it 'shopping_idが空の時' do
        @item.shopping_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を選択してください")
      end

      it 'shopping_idが1の時' do
        @item.shopping_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を選択してください")
      end

      it 'prefecture_idが空の時' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を選択してください")
      end

      it 'prefecture_idが1の時' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を選択してください")
      end

      it 'day_idが空の時' do
        @item.day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を選択してください")
      end

      it 'day_idが1の時' do
        @item.day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を選択してください")
      end

      it 'priceが空の時' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("値段を入力してください", "値段は300円~9999999円")
      end

      it 'priceが半角英数字以外の場合' do
        @item.price = '１２３'
        @item.valid?
        expect(@item.errors.full_messages).to include("値段は300円~9999999円")
      end

      it 'priceが300以下の場合' do
        @item.price = 111
        @item.valid?
        expect(@item.errors.full_messages).to include("値段は300円~9999999円")
      end

      it 'priceが9999999以上の場合' do
        @item.price = 99_999_999
        @item.valid?
        expect(@item.errors.full_messages).to include("値段は300円~9999999円")
      end

      it 'imageが空の時' do
        @item.image = ''
        @item.valid?
        binding.pry
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
    end
  end
end
