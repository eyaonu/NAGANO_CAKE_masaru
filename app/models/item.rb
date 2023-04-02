class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_one_attached :image
  belongs_to :genre

  enum sales_status: { on_sale: 0, off_sale: 1 }

#  validates :image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true

def with_tax_price
    (price * 1.1).floor
end

end