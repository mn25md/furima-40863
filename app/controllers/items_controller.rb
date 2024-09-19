class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:edit, :update, :show]
  before_action :redirect_if_sold, only: [:edit]
  before_action :redirect_unless_owner, only: [:edit, :update]
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item, notice: '商品が作成されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: '商品情報が更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def redirect_unless_owner
    return if current_user.id == @item.user_id

    redirect_to root_path, alert: 'この商品の編集権限がありません。'
  end

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_cost_id, :prefecture_id,
                                 :shipping_day_id, :price, :image).merge(user_id: current_user.id)
  end

  def redirect_if_sold
    return unless @item.sold_out?

    redirect_to root_path, alert: 'この商品はすでに売却済みです。'
  end
end
