# 管理画面：削除済み備品の一覧と復元
class AdminDiscardedItemsController < ApplicationController
  before_action :set_discarded_item, only: %i[restore]

  def index
    @items = Item.discarded.order(discarded_at: :desc).page(params[:page]).per(20)
  end

  # discarded_at を消して通常の一覧に戻す
  def restore
    if @item.undiscard
      redirect_to admin_discarded_items_path, notice: t("flash.restored", model: "備品")
    else
      redirect_to admin_discarded_items_path, alert: t("flash.error")
    end
  end

  private

  def set_discarded_item
    @item = Item.discarded.find(params[:id])
  end
end
