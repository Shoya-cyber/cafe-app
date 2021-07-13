# Cafe-app

# 架空のカフェのホームページ

# URL 

# テストアカウント
  * 管理者
  * 購入者
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
    商品購入をしたいユーザーはユーザー登録をする。

  * 商品一覧
    オンラインでショップの商品を購入することができる。

  * カート機能
    セッションを利用して複数の商品を同時に購入できる。

  * ユーザー詳細ページ
    登録情報、購入履歴を確認できる。




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


## cards テーブル

|  Column       |  Type        |  Option                           |
|  -----------  |  ----------  |  -------------------------------  |  
|  user         |  references  |  null: false,  foreign_key: ture  |  
|  customer_id  |  string      |  null: false                      |
|  card_id      |  string      |  null: false                      |

### Association

- belongs_to :user


## products テーブル

|  Column        |  Type     |  Option       |
|  ------------  |  -------  |  -----------  |  
|  product_name  |  string   |  null: false  |  
|  info          |  text     |  null: false  |
|  price         |  integer  |  null: false  |

### Association

- has_many :order_details
- has_many :orders, through::order_details
- has_many :line_items, depenent::destroy


## orders テーブル

|  Column        |  Type     |  Option                         |
|  ------------  |  -------  |  -----------------------------  |  
|  user      |  references  |  null: false, foreign_key: ture  |  
|  address   |  references  |  null: false, foreign_key: ture  |
|  card      |  references  |  null: false, foreign_key: ture  |
|  product   |  references  |  null: false, foreign_key: ture  |
|  quantity  |  integer     |  null: false                     |
|  price     |  integer     |  null: false                     |

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


## carts テーブル

|  Column        |  Type     |  Option       |
|  ------------  |  -------  |  -----------  |
|                |           |               |

### Association

- has_many :line_items, dependent::destroy


## line_items テーブル

|  Column    |  Type        |  Option                          |
|  --------  |  ----------  |  ------------------------------  |
|  product   |  references  |  null: false, foreign_key: ture  |
|  cart      |  references  |  null: false, foreign_key: ture  |
|  quantity  |  integer     |  default: 0, null: false         |

### Association

- belongs_to :product
- belongs_to :cart

# ローカルでの動作方法
 git clone https://github.com/Shoya-cyber/cafe-app

  rails 6.0.0
  Ruby/Ruby on Rails/MySQL/Github/AWS/Visual Studio Code