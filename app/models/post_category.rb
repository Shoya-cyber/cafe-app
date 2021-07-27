class PostCategory < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'お知らせ' },
    { id: 3, name: 'ブログ' },
    { id: 4, name: '新商品' }
  ]
end
