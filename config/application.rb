require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MendoApp
  class Application < Rails::Application
    # Rails 7.1 のデフォルト設定を読み込む
    config.load_defaults 7.1

    # lib/ ディレクトリの自動読み込み設定（assets と tasks は除外）
    config.autoload_lib(ignore: %w(assets tasks))

    # タイムゾーンを日本時間（JST）に設定
    # → created_at などの時刻が日本時間で表示される
    config.time_zone = "Tokyo"

    # データベースに保存する時刻のタイムゾーンを UTC のまま保持する（推奨設定）
    config.active_record.default_timezone = :utc

    # アプリ全体のデフォルト言語を日本語に設定
    # → バリデーションエラーなどが日本語で表示される
    config.i18n.default_locale = :ja

    # 日本語が見つからない場合の fallback 言語を英語にする
    config.i18n.fallbacks = [:en]
  end
end
