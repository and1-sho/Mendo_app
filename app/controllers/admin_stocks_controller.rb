# 管理画面：在庫一覧（在庫を見る。編集・削除は備品一覧側）
class AdminStocksController < ApplicationController
  def index
    @items = Item.kept.order(:item_code).page(params[:page]).per(20)
  end

  def show
    @item = Item.kept.find(params[:id])
  end
end
