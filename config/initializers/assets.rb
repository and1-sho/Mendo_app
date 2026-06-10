# Be sure to restart your server when you modify this file.

# アセットのバージョン（変更するとキャッシュが無効化される）
Rails.application.config.assets.version = "1.0"

# SCSS のサブディレクトリをアセットの読み込みパスに追加する
# → @import "base/variables" のように相対パスで読み込めるようになる
Rails.application.config.assets.paths << Rails.root.join("app/assets/stylesheets/base")
Rails.application.config.assets.paths << Rails.root.join("app/assets/stylesheets/components")
Rails.application.config.assets.paths << Rails.root.join("app/assets/stylesheets/layouts")
