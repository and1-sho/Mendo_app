# 管理画面：在庫一覧（在庫を見る。編集・削除は備品一覧側）
class AdminStocksController < ApplicationController
  def index
    @items = Item.kept.order(:item_code).page(params[:page]).per(20)

    if turbo_frame_request?
      render inline: ""
    end
  end

  def show
    @item = Item.kept.find(params[:id])

    unless turbo_frame_request?
      redirect_to admin_stocks_path
      return
    end

    render partial: "item_detail_modal", locals: { item: @item }
  end
end
