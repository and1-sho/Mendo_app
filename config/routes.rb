Rails.application.routes.draw do
  # ヘルスチェック用
  get "up" => "rails/health#show", as: :rails_health_check

  # トップページ（画面①：テンキー入力画面）
  root "inputs#index"

  # 商品番号を送信して判定する
  post "inputs", to: "inputs#create", as: :inputs

  # 管理画面（備品の一覧・登録・編集・削除）
  resources :admin_items, path: "admin/items"
end
