Rails.application.routes.draw do
  devise_for :users
  # ヘルスチェック用
  get "up" => "rails/health#show", as: :rails_health_check

  # トップページ（画面①：テンキー入力画面）
  root "inputs#index"

  # 商品番号を送信して判定する
  post "inputs", to: "inputs#create", as: :inputs

  # 画面②：在庫を減らす（個数入力 + 確定）
  resources :stock_reductions, only: %i[new create]

  # 管理画面（備品の一覧・登録・編集・削除）
  resources :admin_items, path: "admin/items"
end
