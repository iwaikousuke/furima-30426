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
      it 'nameが空の時' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'textが空の時' do
        @item.text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Text can't be blank")
      end

      it 'category_idが空の時' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank", "Category is not a number")
      end

      it 'category_idが1の時' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end

      it 'status_idが空の時' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank", "Status is not a number")
      end

      it 'status_idが1の時' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Status must be other than 1")
      end

      it 'shopping_idが空の時' do
        @item.shopping_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shopping can't be blank", "Shopping is not a number")
      end

      it 'shopping_idが1の時' do
        @item.shopping_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shopping must be other than 1")
      end

      it 'prefecture_idが空の時' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank", "Prefecture is not a number")
      end

      it 'prefecture_idが1の時' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end

      it 'day_idが空の時' do
        @item.day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Day can't be blank", "Day is not a number")
      end


      it 'day_idが1の時' do
        @item.day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Day must be other than 1")
      end

      it 'priceが空の時' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", "Price 300~9999999")
      end

      it 'priceが半角英数字以外の場合' do
        @item.price = １２３４５
        @item.valid?
        binding.pry
        expect(@item.errors.full_messages).to include("Price 300~9999999")
      end

      it 'priceが300以下の場合' do
        @item.price = 111
        @item.valid?
        expect(@item.errors.full_messages).to include("Price 300~9999999")
      end

      it 'priceが9999999以上の場合' do
        @item.price = 99999999
        @item.valid?
        expect(@item.errors.full_messages).to include("Price 300~9999999")
      end


      it 'imageが空の時' do
        @item.image = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
    end
  end
end