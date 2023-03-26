class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items
  has_many :orders
  has_many :ordered_items, through: :orders

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postal_code, presence: true
  validates :telephone_number, presence: true
  validates :address, presence: true
  validates :email, presence: true

  def address_display
  '〒' + postal_code + ' ' + address
  end

  def fullname_display
    first_name + last_name
  end

end