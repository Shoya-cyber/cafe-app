require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '商品購入情報の保存' do
    before do
      @order = FactoryBot.build(:order)
    end

    context '商品購入情報を保存できるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order).to be_valid
      end
    end

    context '商品購入情報を保存できないとき' do
      it 'total_quantityが空では保存できないこと' do
        @order.total_quantity = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Total quantity can't be blank")
      end
      it 'total_priceが空では保存できないこと' do
        @order.total_price = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Total price can't be blank")
      end
    end
  end
end
