Rails.application.routes.draw do
  devise_for :users

  # 開発環境で送信メールをブラウザ確認する（http://localhost:3000/letter_opener）
  # gem が未インストールでも他のルートが読み込めるよう defined? で囲む
  if Rails.env.development? && defined?(LetterOpenerWeb::Engine)
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # ヘルスチェック用
  get "up" => "rails/health#show", as: :rails_health_check

  # トップページ（画面①：テンキー入力画面）
  root "inputs#index"

  # 商品番号を送信して判定する
  post "inputs", to: "inputs#create", as: :inputs

  # 画面②：在庫を減らす（個数入力 + 確定）
  resources :stock_reductions, only: %i[new create]

  # バーコードスキャン（カメラ画面 + API）
  get "scan", to: "items/scans#new", as: :scan
  post "items/scan", to: "items/scans#create", as: :items_scan

  # 管理画面（備品の一覧・登録・編集・削除）
  # show は未使用。残すと削除失敗時などに GET /admin/items/:id で 404 になりやすい
  resources :admin_items, path: "admin/items", except: %i[show]
end
