Rails.application.routes.draw do
  devise_for :users

  # 開発環境で送信メールをブラウザ確認する（http://localhost:3000/letter_opener）
  # gem が未インストールでも他のルートが読み込めるよう defined? で囲む
  if Rails.env.development? && defined?(LetterOpenerWeb::Engine)
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # ヘルスチェック用
  get "up" => "rails/health#show", as: :rails_health_check

  # トップページ = バーコードスキャン（主役画面）
  root "items/scans#new"

  # 手入力（テンキー）。スキャン画面の「手入力する」から来る
  get "manual_input", to: "inputs#index", as: :manual_input

  # 商品番号を送信して判定する
  post "inputs", to: "inputs#create", as: :inputs

  # 画面②：在庫を減らす（個数入力 + 確定）
  resources :stock_reductions, only: %i[new create]

  # バーコードスキャン API と /scan エイリアス
  get "scan", to: "items/scans#new", as: :scan
  post "items/scan", to: "items/scans#create", as: :items_scan

  # 初回スタッフ名登録
  resources :staffs, only: %i[new create] do
    get :registered, on: :collection
  end

  # 管理画面（備品の一覧・登録・編集・削除）
  # show は未使用。残すと削除失敗時などに GET /admin/items/:id で 404 になりやすい
  resources :admin_items, path: "admin/items", except: %i[show] do
    # 入庫（在庫を増やして履歴に残す）
    resource :stock_receipt, only: %i[new create], controller: "admin_stock_receipts"
  end

  # 管理画面：入出庫履歴
  resources :admin_stock_histories, path: "admin/stock_histories", only: %i[index]

  # 管理画面：在庫一覧（見る専用。設定・編集は備品一覧側）
  resources :admin_stocks, path: "admin/stocks", only: %i[index show]
end
