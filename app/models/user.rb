class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_one :card, dependent: :destroy

  with_options presence: true do
    validates :name
    validates :name_reading, format: { with: /\A[ァ-ヶー－　]+\z/, message: 'is invalid. Input full-width characters.' }
    validates :email, uniqueness: true
    validates :password
    validates :phone_number, length: { maximum: 11 }
    validates :birth_date
  end

  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Not include hyphen(-).' }

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'is invalid. Password Include both letters and numbers.'
end
