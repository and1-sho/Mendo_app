class InputsController < ApplicationController
  # 画面①：テンキー入力画面を表示する
  def index
  end

  # 決定ボタンを押したときの処理
  def create
    code = params[:item_code].to_i

    # 9999 が入力されたら管理画面へ
    if code == 9999
      redirect_to admin_items_path
      return
    end

    # 入力された商品番号の備品を検索する
    item = Item.find_by(item_code: code)

    if item
      # 備品が見つかったら画面②へ（商品番号をURLパラメータで渡す）
      redirect_to new_stock_reduction_path(item_code: code)
    else
      # 見つからなければエラーメッセージを出して画面①に戻る
      redirect_to root_path, alert: "商品番号 #{code} の備品は見つかりませんでした"
    end
  end
end
