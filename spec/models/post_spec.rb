require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#create' do
    before do
      @post = FactoryBot.build(:post)
    end

    describe '記事投稿機能' do
      context '記事投稿が上手くいくとき' do
        it 'すべての値が正しく入力されていれば保存できること' do
          expect(@post).to be_valid
        end
      end
      
      context '記事投稿が上手く行かないとき' do
        it 'post_category_idが空では保存できないこと' do
          @post.post_category_id = nil
          @post.valid?
          expect(@post.errors.full_messages).to include("Post category can't be blank", "Post category is not a number")
        end
        it 'post_category_idが1では保存できないこと' do
          @post.post_category_id = 1
          @post.valid?
          expect(@post.errors.full_messages).to include("Post category must be other than 1")
        end
        it 'titleが空では保存できないこと' do
          @post.title = nil
          @post.valid?
          expect(@post.errors.full_messages).to include("Title can't be blank")
        end
        it 'titleが51文字以上では保存できないこと' do
          @post.title = ('a' * 51)
          @post.valid?
          expect(@post.errors.full_messages).to include("Title is too long (maximum is 50 characters)")
        end
        it 'textが空では保存できないこと' do
          @post.text = nil
          @post.valid?
          expect(@post.errors.full_messages).to include("Text can't be blank")
        end
        it 'imageが空では保存できないこと' do
          @post.image = nil
          @post.valid?
          expect(@post.errors.full_messages).to include("Image can't be blank")
        end
      end
    end
  end
end