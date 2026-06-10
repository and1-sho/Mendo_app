# 在庫管理システム

社内向けの在庫管理Webアプリケーションです。

---

## 技術スタック

| 項目 | バージョン |
|------|-----------|
| Ruby | 3.3.10 |
| Rails | 7.1.6 |
| データベース | SQLite（開発環境） |
| フロントエンド | Hotwire（Turbo + Stimulus）、importmap |
| CSS | 自前のSCSS |
| 開発環境 | Docker |

---

## 開発環境のセットアップ手順

### 必要なもの（事前にインストールしておく）

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)

### 手順

**① リポジトリをクローン**

```bash
git clone https://github.com/あなたのユーザー名/mendo_app.git
cd mendo_app
```

**② 環境変数ファイルを作成（初回のみ）**

```bash
cp .env.example .env
```

開発環境ではこのままで動きます。中身の編集は不要です。

**③ Dockerイメージをビルド**

```bash
docker compose build
```

**④ サーバーを起動**

```bash
docker compose up
```

ブラウザで [http://localhost:3000](http://localhost:3000) にアクセスして画面が表示されれば完了です。

## よく使うコマンド

```bash
# サーバーを起動する
docker compose up

# サーバーをバックグラウンドで起動する（ターミナルを占有しない）
docker compose up -d

# サーバーを停止する
docker compose down

# Railsコンソールを開く（データの確認・操作に使う）
docker compose run --rm web bin/rails console

# マイグレーションを実行する（DBの構造を更新する）
docker compose run --rm web bin/rails db:migrate

# gemを追加したあとに実行する
docker compose run --rm web bundle install
docker compose build
```
