class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :shipping_day
  has_one :order
  belongs_to :user

  has_one_attached :image

  validates :image, presence: { message: "can't be blank" }
  validates :product_name, presence: { message: "can't be blank" }
  validates :product_description, presence: { message: "can't be blank" }
  validates :price, presence: { message: "can't be blank" },
                    numericality: { only_integer: true, message: 'is not a number', greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :condition_id, numericality: { other_than: 1, message: "Sales status can't be blank" }
  validates :shipping_cost_id, numericality: { other_than: 1, message: "Shipping fee status can't be blank" }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_day_id, numericality: { other_than: 1, message: "Scheduled delivery can't be blank" }

  def sold_out?
    order.present?
  end
end
