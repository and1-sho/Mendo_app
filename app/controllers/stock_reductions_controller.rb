class StockReductionsController < ApplicationController
  # 画面②：備品の確認 + 個数入力画面を表示する
  def new
    # 画面①から渡された商品番号で備品を検索する
    @item = Item.find_by(item_code: params[:item_code])

    # 備品が見つからない場合は画面①に戻る
    unless @item
      redirect_to root_path, alert: "備品が見つかりませんでした"
    end
  end

  # 決定ボタンを押したときの処理（在庫を減らす）
  def create
    @item = Item.find(params[:item_id])
    quantity = params[:quantity].to_i

    # 個数が入力されていない場合
    if quantity <= 0
      redirect_to new_stock_reduction_path(item_code: @item.item_code), alert: "個数を入力してください"
      return
    end

    # 在庫数より多い個数が入力された場合
    if quantity > @item.stock
      redirect_to new_stock_reduction_path(item_code: @item.item_code), alert: "在庫数が足りません（現在の在庫: #{@item.stock}）"
      return
    end

    # 在庫を減らして保存する
    @item.update!(stock: @item.stock - quantity)

    # 画面①に戻り「記録しました」を表示する
    redirect_to root_path, notice: "記録しました"
  end
end
