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
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したemailの登録ができない事' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailに＠が含まれていない時' do
        @user.email = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordとpassword_confirmationの確認用がない場合、passwordが空の場合' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank", "Password confirmation doesn't match Password")
      end

      it 'passwordとpassword_confirmationの値が一致しない場合、passwordが6文字以内の場合' do
        @user.password = 'aaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", 'Password is too short (minimum is 6 characters)')
      end

      it 'first_name,last_nameが空の場合' do
        @user.first_name = ''
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", 'Last name is invalid. Input full-width characters.', "First name can't be blank", 'First name is invalid. Input full-width characters.')
      end

      it 'ユーザー本名が、全角（漢字・ひらがな・カタカナ)以外の場合' do
        @user.first_name = 'aa'
        @user.last_name = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.', 'First name is invalid. Input full-width characters.')
      end

      it 'first_name_kana,last_name_kanaが空,全角(カタカナ)以外の場合,' do
        @user.first_name_kana = ''
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank", "First name kana can't be blank")
      end

      it 'first_name_kana,last_name_kanaが全角(カタカナ)以外の場合' do
        @user.first_name_kana = 'あいう'
        @user.last_name_kana = 'あいう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters.', 'First name kana is invalid. Input full-width katakana characters.')
      end

      it 'birth_dateが空の場合' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
