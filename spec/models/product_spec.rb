require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#create' do
    before do
      @product = FactoryBot.build(:product)
    end

    describe '商品投稿機能' do
      context '商品投稿が上手くいくとき' do
        it 'すべての値が正しく入力されていれば保存できないこと' do
          expect(@product).to be_valid
        end
      end

      context '商品投稿が上手くいかないとき' do
        it 'product_nameが空では保存できないこと' do
          @product.product_name = nil
          @product.valid?
          expect(@product.errors.full_messages).to include("Product name can't be blank")
        end
        it 'infoが空では保存できないこと' do
          @product.info = nil
          @product.valid?
          expect(@product.errors.full_messages).to include("Info can't be blank")
        end
        it 'infoが51文字以上では保存できないこと' do
          @product.info = ("a" * 51)
          @product.valid?
          expect(@product.errors.full_messages).to include("Info is too long (maximum is 50 characters)")
        end
        it 'priceが空では保存できないこと' do
          @product.price = nil
          @product.valid?
          expect(@product.errors.full_messages).to include("Price can't be blank", "Price is invalid")
        end
        it 'priceが全角数字では保存できないこと' do
          @product.price = "３００"
          @product.valid?
          expect(@product.errors.full_messages).to include("Price is not a number")
        end
        it 'imageが空では保存できないこと' do
          @product.image = nil
          @product.valid?
          expect(@product.errors.full_messages).to include("Image can't be blank")
        end
      end
    end
  end
end
