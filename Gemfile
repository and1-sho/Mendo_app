source "https://rubygems.org"

ruby "3.3.10"

# Rails 本体
gem "rails", "~> 7.1.6"

# アセットパイプライン（CSS・JS ファイルをまとめる仕組み）
gem "sprockets-rails"

# 開発・テストは SQLite、本番は PostgreSQL（Supabase）を使う
gem "sqlite3", ">= 1.4", group: [:development, :test]
gem "pg", "~> 1.5", group: :production

# Webサーバー
gem "puma", ">= 5.0"

# JavaScript を <script type="importmap"> で管理する（Node.js 不要）
gem "importmap-rails"

# Hotwire: ページ遷移を高速化する Turbo
gem "turbo-rails"

# Hotwire: 軽量 JavaScript フレームワーク Stimulus
gem "stimulus-rails"

# JSON レスポンスを簡単に作れる（APIモードでなくても便利）
gem "jbuilder"

# Windows / JRuby 向けタイムゾーンデータ（Mac では使われないが書いておく）
gem "tzinfo-data", platforms: %i[ windows jruby ]

# 起動時のキャッシュで Rails の起動を高速化する
gem "bootsnap", require: false

# 画像のリサイズ・変換に必要（Active Storage と組み合わせて使う）
gem "image_processing", "~> 1.2"

# ユーザー認証（ログイン・サインアップ）を簡単に実装できる
gem "devise", "~> 5.0"

# Devise の日本語訳を自動で追加する
gem "devise-i18n"

# Rails 標準メッセージ（エラーなど）の日本語訳
gem "rails-i18n", "~> 7.0.10"

# ページネーション
gem "kaminari"

# .env ファイルから環境変数を読み込む（APIキーなど秘密情報の管理に使う）
gem "dotenv-rails", "~> 3.2"

group :development, :test do
  # デバッグツール（binding.break でコードを止めて変数を確認できる）
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  # エラー画面でブラウザからコンソールを使えるようにする
  gem "web-console"

  # 開発環境で送信メールをブラウザで確認する（/letter_opener）
  gem "letter_opener_web", "~> 3.0"
end

group :test do
  # Rails 7.1 系との互換のため 5 系に固定
  gem "minitest", "~> 5.25"
  # システムテスト（ブラウザ操作の自動テスト）に必要
  gem "capybara"
  gem "selenium-webdriver"
end
