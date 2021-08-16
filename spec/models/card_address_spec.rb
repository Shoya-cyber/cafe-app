require 'rails_helper'

RSpec.describe CardAddress, type: :model do
  describe 'カードとお届け先の保存' do
    before do
      @card_address = FactoryBot.build(:card_address)
    end

    context 'カードとお届け先を保存できるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@card_address).to be_valid
      end
      it 'building_nameが空でも保存できること' do
        @card_address.building_name = nil
        expect(@card_address).to be_valid
      end
    end

    context 'カードとお届け先が保存できないとき' do
      it 'card_idが空では保存できないこと' do
        @card_address.card_id = nil
        @card_address.valid?
        expect(@card_address.errors.full_messages).to include("Card can't be blank")
      end
      it 'customer_idが空では保存できないこと' do
        @card_address.customer_id = nil
        @card_address.valid?
        expect(@card_address.errors.full_messages).to include("Customer can't be blank")
      end
      it 'postal_codeが空では保存できないこと' do
        @card_address.postal_code = nil
        @card_address.valid?
        expect(@card_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeにハイフンが含まれていると保存できないこと' do
        @card_address.postal_code = '123-4567'
        @card_address.valid?
        expect(@card_address.errors.full_messages).to include('Postal code is invalid. Not include hyphen(-).')
      end
      it 'prefecture_idが空では保存できないこと' do
        @card_address.prefecture_id = nil
        @card_address.valid?
        expect(@card_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'prefecture_idが1では保存できないこと' do
        @card_address.prefecture_id = 1
        @card_address.valid?
        expect(@card_address.errors.full_messages).to include('Prefecture is not selected.')
      end
      it 'cityが空では保存できないこと' do
        @card_address.city = nil
        @card_address.valid?
        expect(@card_address.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberが空では保存できないこと' do
        @card_address.house_number = nil
        @card_address.valid?
        expect(@card_address.errors.full_messages).to include("House number can't be blank")
      end
    end
  end
end
