require 'rails_helper'

describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー,本人新規登録' do
    context '新規登録が出来る時' do
      it 'nicknameとemail, passwordとpassword_confirmation,last_name,first_name,last_name_kana,first_name_kana,birth-dateが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない時' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end

      it '重複したemailの登録ができない事' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end

      it 'emailに＠が含まれていない時' do
        @user.email = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'passwordとpassword_confirmationの確認用がない場合、passwordが空の場合' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワード 半角英数字混同で入力してください", "パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'passwordとpassword_confirmationの値が一致しない場合、passwordが6文字以内の場合' do
        @user.password = 'aaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードは6文字以上で入力してください", "パスワード 半角英数字混同で入力してください")
      end

      it 'first_nameが空の場合' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください", "名前全角で入力してください")
      end

      it 'last_nameが空の場合' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字を入力してください", "名字全角で入力してください")
      end

      it 'first_nameが全角（漢字・ひらがな・カタカナ)以外の場合' do
        @user.first_name = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前全角で入力してください")
      end

      it 'first_nameが全角（漢字・ひらがな・カタカナ)以外の場合' do
        @user.first_name = '123'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前全角で入力してください")
      end

      it 'last_nameが全角（漢字・ひらがな・カタカナ)以外の場合' do
        @user.last_name = '123'
        @user.valid?
        expect(@user.errors.full_messages).to include("名字全角で入力してください")
      end

      it 'last_nameが全角（漢字・ひらがな・カタカナ)以外の場合' do
        @user.last_name = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include("名字全角で入力してください")
      end

      it 'first_name_kanaが空の場合' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください", "名前全角カタカナで入力してください")
      end

      it 'last_name_kanaが空の場合' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字を入力してください", "名字全角カタカナで入力してください")
      end

      it 'first_name_kanaが全角(カタカナ)以外の場合' do
        @user.first_name_kana = 'あいう'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前全角カタカナで入力してください")
      end

      it 'first_name_kanaが全角(カタカナ)以外の場合' do
        @user.first_name_kana = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前全角カタカナで入力してください")
      end

      it 'first_name_kanaが全角(カタカナ)以外の場合' do
        @user.first_name_kana = '123'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前全角カタカナで入力してください")
      end

      it 'last_name_kanaが全角(カタカナ)以外の場合' do
        @user.last_name_kana = 'あいう'
        @user.valid?
        expect(@user.errors.full_messages).to include("名字全角カタカナで入力してください")
      end

      it 'last_name_kanaが全角(カタカナ)以外の場合' do
        @user.last_name_kana = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include("名字全角カタカナで入力してください")
      end

      it 'last_name_kanaが全角(カタカナ)以外の場合' do
        @user.last_name_kana = '123'
        @user.valid?
        expect(@user.errors.full_messages).to include("名字全角カタカナで入力してください")
      end

      it 'birth_dateが空の場合' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
