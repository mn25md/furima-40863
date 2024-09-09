class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :shipping_day, class_name: 'ShippingDay', foreign_key: 'shipping_day_id'

  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :category_id, numericality: { other_than: 1, message: "can't be ---" }
  validates :condition_id, numericality: { other_than: 1, message: "can't be ---" }
  validates :shipping_cost_id, numericality: { other_than: 1, message: "can't be ---" }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be ---" }
  validates :shipping_day_id, numericality: { other_than: 1, message: "can't be ---" }
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :image, presence: true
  def sold_out?
    is_sold
  end
end
