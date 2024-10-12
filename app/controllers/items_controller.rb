class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :redirect_if_sold, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params) # ここで user_id のマージを削除しました
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

  def destroy
    if @item.destroy
      redirect_to root_path, notice: '商品が削除されました。'
    else
      redirect_to @item, alert: '商品の削除に失敗しました。'
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: '指定された商品は存在しません。'
  end

  def correct_user
    return if current_user.id == @item.user_id

    redirect_to root_path, alert: 'この商品の編集権限がありません。'
  end

  def redirect_if_sold
    return unless @item.sold_out?

    redirect_to root_path, alert: '売却済み商品の編集や削除はできません。'
  end

  def item_params
    params.require(:item).permit(:product_name, :product_description, :category_id, :condition_id, :shipping_cost_id, :prefecture_id,
                                 :shipping_day_id, :price, :image).merge(user_id: current_user.id)
  end
end
