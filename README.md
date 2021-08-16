# Cafe-app

# 架空のカフェのホームページ

# URL https://cafe-app-30527.herokuapp.com/

# テストアカウント
  * 管理者 name:テスト1, name_reading:テストイチ, email:test1@com, phone_number:09012345678, birth_date:1930-01-01
  * 購入者 name:テスト2, name_reading:テストニ, email:test2@com, phone_number:09023456789, birth_date:1930-02-01
          お届け先 郵便番号:1234567,　都道府県:北海道,　市区町村:test,　町名番地:test, 建物名:test
          テストカード 4242424242424242, 1/25, 123 
  * Basic認証 ID: admin password: 2222

# 利用方法
トップページから目的のページに遷移して情報を閲覧できる。
管理者は記事の投稿や編集ができる。
商品購入がしたい場合は、ユーザー登録をすることで商品購入ができる。
ユーザー登録者はマイページで登録情報や購入履歴を確認できる。

# 洗い出した要件
  * ユーザー登録なしでも情報を閲覧できる。

  * 管理者権限
    管理者だけが記事の投稿、編集、削除ができる。

  * ユーザー登録
    商品購入をしたいユーザーはユーザー登録をする。。

  * カート機能
    セッションを利用して複数の商品を同時に購入できる。

  * 商品購入機能
    登録した住所とクレジットカードの情報で商品を購入できる。

  * ユーザー詳細ページ
    登録情報、購入履歴を確認できる。

  * 記事投稿機能
    管理者はお知らせやブログの記事を投稿できる。

  * 商品投稿機能
    管理者はオンラインストア商品を投稿できる。





# テーブル設計

## users テーブル

|  Column        |  Type    |  Option        |
|  ------------  |  ------  |  ------------  |
|  name          |  string  |  null:  false  |
|  name_reading  |  string  |  null:  false  |
|  email         |  string  |  null:  false  |
|  phone_number  |  string  |  null:  false  |
|  birth_date    |  date    |  null:  false  |
|  password      |  string  |  null:  false  |

### Association

- has_many :posts
- has_one :addresses, dependent::destroy
- has_one :card, dependent::destroy
- has_many :orders, dependent::nullify


## posts テーブル

|  Column            |  Type        |  Option                           |
|  ----------------  |  ----------  |  -------------------------------  |
|  post_category_id  |  integer     |  null:  false                     |
|  title             |  string      |  null:  false                     |
|  text              |  text        |  null:  false                     |
|  user              |  references  |  null:  false, foreign_key: ture  |

### Association

- belongs_to :user


## addresses テーブル

|  Column         |  Type        |  Option                          |
|  -------------  |  ----------  |  ------------------------------  |
|  postal_code    |  string      |  null: false                     |
|  pefecture_id   |  integer     |  null: false                     |
|  city           |  string      |  null: false                     |
|  house_number   |  string      |  null: false                     |
|  building_name  |  string      |                                  |
|  user           |  references  |  null: false, foreign_key: ture  |

### Association

- belongs_to :user
- has_one :order, dependent: :nullify


## cards テーブル

|  Column       |  Type        |  Option                           |
|  -----------  |  ----------  |  -------------------------------  |  
|  user         |  references  |  null: false,  foreign_key: ture  |  
|  customer_id  |  string      |  null: false                      |
|  card_id      |  string      |  null: false                      |

### Association

- belongs_to :user
- has_one :order, dependent: :nullify


## products テーブル

|  Column        |  Type     |  Option       |
|  ------------  |  -------  |  -----------  |  
|  product_name  |  string   |  null: false  |  
|  info          |  text     |  null: false  |
|  price         |  integer  |  null: false  |

### Association

- has_many :order_details
- has_many :orders, through::order_details


## orders テーブル

|  Column          |  Type        |  Option                          |
|  --------------  |  ----------  |  ------------------------------  |  
|  user            |  references  |  null: false, foreign_key: ture  |
|  address         |  references  |  null: false, foreign_key: ture  |
|  card            |  references  |  null: false, foreign_key: ture  |
|  total_quantity  |  integer     |  null: false                     |
|  total_price     |  integer     |  null: false                     |

### Association

- belongs_to :user
- belongs_to :address
- belongs_to :card
- has_many :products, through::order_details
- has_many :order_details, dependent::destroy


## order_details テーブル

|  Column    |  Type        |  Option                          |
|  --------  |  ----------  |  ------------------------------  |  
|  product   |  references  |  null: false, foreign_key: ture  |  
|  order     |  references  |  null: false, foreign_key: ture  |
|  quantity  |  integer     |  null: false                     |

### Association

- belongs_to :product
- belongs_to :order



# ローカルでの動作方法
 git clone https://git.heroku.com/cafe-app-30527.git

  rails 6.0.0
  Ruby/Ruby on Rails/MySQL/Github/AWS/Visual Studio Code