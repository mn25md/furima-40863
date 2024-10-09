class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_invalid_access, only: [:index, :create]

  def index
    gon.public_key = ENV.fetch('PAYJP_PUBLIC_KEY', nil)
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path, notice: '購入が完了しました。'
    else
      gon.public_key = ENV.fetch('PAYJP_PUBLIC_KEY', nil)
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_invalid_access
    return unless current_user.id == @item.user_id || @item.sold_out?

    redirect_to root_path, alert: '購入できません。'
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV.fetch('PAYJP_SECRET_KEY', nil)
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
