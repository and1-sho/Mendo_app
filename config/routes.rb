Rails.application.routes.draw do
  # ヘルスチェック用（サーバーが正常に動いているか確認するURL）
  get "up" => "rails/health#show", as: :rails_health_check

  # 管理画面（備品の一覧・登録・編集・削除）
  resources :admin_items, path: "admin/items"

  # トップページ（画面①：テンキー入力画面）※ブランチ③で実装
  # root "inputs#index"
end
