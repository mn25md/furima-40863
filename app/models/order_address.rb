class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :address, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :token, presence: { message: "can't be blank" }
    validates :post_code, presence: { message: "can't be blank" },
                          format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city, presence: { message: "can't be blank" }
    validates :address, presence: { message: "can't be blank" }
    validates :phone_number, presence: { message: "can't be blank" },
                             format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' }, length: { minimum: 10, message: 'is too short' }
    validates :user_id
    validates :item_id
  end

  def save
    # Orderモデルに購入情報を保存
    order = Order.create(user_id:, item_id:)

    # Addressモデルに住所情報を保存
    Address.create(
      post_code:,
      prefecture_id:,
      city:,
      address:,
      building:,
      phone_number:,
      order_id: order.id
    )
  end
end
