class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:edit, :update, :show]
  # before_action :redirect_if_sold, only: [:edit]
  before_action :correct_user, only: [:edit, :update]
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
    @item = Item.find_by(id: params[:id])
    return unless @item.nil?

    redirect_to root_path, alert: '指定された商品は存在しません。'
  end

  def correct_user
    return if current_user.id == @item.user_id

    redirect_to root_path, alert: 'この商品の編集権限がありません。'
  end

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_cost_id, :prefecture_id,
                                 :shipping_day_id, :price, :image).merge(user_id: current_user.id)
  end
end
