# 管理画面：備品の入庫（在庫を増やす）
class AdminStockReceiptsController < ApplicationController
  before_action :set_item

  # 入庫画面（個数入力）
  def new
  end

  # 入庫処理
  def create
    result = ItemStockReceipt.new(
      user: current_user,
      item: @item,
      quantity: params[:quantity]
    ).call

    if result[:success]
      redirect_to admin_items_path, notice: result[:message]
    else
      flash.now[:alert] = result[:message]
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:admin_item_id])
  end
end
