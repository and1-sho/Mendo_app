class AdminItemsController < ApplicationController
  # 編集・更新・削除のアクションで事前に備品を取得しておく
  before_action :set_item, only: %i[edit update destroy]

  # 一覧画面
  def index
    @items = Item.order(:item_code).page(params[:page]).per(20)
  end

  # 登録画面（フォームを表示）
  def new
    @item = Item.new
  end

  # 登録処理
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path, notice: t("flash.created", model: "備品")
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 編集画面（フォームを表示）
  def edit
  end

  # 更新処理
  def update
    if @item.update(item_params)
      redirect_to admin_items_path, notice: t("flash.updated", model: "備品"), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # 削除処理
  # status: :see_other … DELETE のあとブラウザが同じ DELETE でリダイレクトしてしまうのを防ぐ
  def destroy
    @item.destroy
    redirect_to admin_items_path, notice: t("flash.destroyed", model: "備品"), status: :see_other
  end

  private

  # URLの :id から備品を取得する
  def set_item
    @item = Item.find(params[:id])
  end

  # フォームから受け取るパラメータを制限する（セキュリティのため）
  def item_params
    params.require(:item).permit(
      :item_code,
      :name,
      :stock,
      :order_trigger,
      :reorder_quantity,
      :image
    )
  end
end
