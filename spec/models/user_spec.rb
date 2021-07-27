require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー新規登録' do
      context '新規登録が上手くいくとき' do
        it '全ての値が正しく入力されていれば保存できること' do
          expect(@user).to be_valid
        end
      end
      context '新規登録が上手くいかないとき' do
        it 'nameが空では保存できないこと' do
          @user.name = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Name can't be blank")
        end
        it 'name_readingが空では保存できないこと' do
          @user.name_reading = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Name reading can't be blank")
        end
        it 'name_readingが半角カナでは保存できないこと' do
          @user.name_reading = 'ｽｽﾞｷ'
          @user.valid?
          expect(@user.errors.full_messages).to include("Name reading is invalid. Input full-width characters.")
        end
        it 'name_readingが全角かなでは保存できないこと' do
          @user.name_reading = 'すずき'
          @user.valid?
          expect(@user.errors.full_messages).to include("Name reading is invalid. Input full-width characters.")
        end
        it 'name_readingが漢字では保存できないこと' do
          @user.name_reading = '鈴木'
          @user.valid?
          expect(@user.errors.full_messages).to include("Name reading is invalid. Input full-width characters.")
        end
        it 'emailが空では保存できないこと' do
          @user.email = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end
        it '重複するemailが存在する場合は保存できないこと' do
          @user.save
          another_user = FactoryBot.build(:user, email: @user.email)
          another_user.valid?
          expect(another_user.errors.full_messages).to include("Email has already been taken")
        end
        it 'emailが@を含まないと保存できないこと' do
          @user.email = 'aaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include("Email is invalid")
        end
        it 'phone_numberが空では保存できないこと' do
          @user.phone_number = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Phone number can't be blank")
        end
        it 'phone_numberにハイフンが含まれると保存できないこと' do
          @user.phone_number = '090-1234-5678'
          @user.valid?
          expect(@user.errors.full_messages).to include("Phone number is invalid. Not include hyphen(-).")
        end
        it 'phone_numberが12桁以上では保存できないこと' do
          @user.phone_number = '090123456789'
          @user.valid?
          expect(@user.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
        end
        
        it 'birth_dateが空では保存できないこと' do
          @user.birth_date = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Birth date can't be blank")
        end
        it 'passwordが空では保存できないこと' do
          @user.password = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end
        it 'passwordが半角数字だけでは保存できないこと' do
          @user.password = '111111'
          @user.password_confirmation = '111111'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password is invalid. Password Include both letters and numbers.")
        end
        it 'passwordが半角英字だけでは保存できないこと' do
          @user.password = 'aaaaaa'
          @user.password_confirmation = 'aaaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password is invalid. Password Include both letters and numbers.")
        end
        it 'passwordが5文字以下では保存できないこと' do
          @user.password = 'abc12'
          @user.password_confirmation = 'abc12'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
        end
        it 'passwordが存在してもpassword_confirmationが空では保存できないこと' do
          @user.password_confirmation = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
      end
    end
  end
end