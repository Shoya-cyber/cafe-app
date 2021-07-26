class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts

  with_options presence: true do
    validates :name
    validates :name_reading, format: { with: /\A[ァ-ヶー－]+\z/, message: '全角カタカナで入力してください'}
    validates :email, uniqueness: true
    validates :password
    validates :phone_number, length: { maximum: 11}, format: { with: /\A\d{10,11}\z/, message: '(-)なし、11桁以内で入力してください'}
    validates :birth_date
  end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: '半角の英字と数字を1文字以上含めてください'

end
