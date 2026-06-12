class ApplicationController < ActionController::Base
  # 全画面でログインを必須にする
  # ログインしていない場合はログイン画面にリダイレクトされる
  before_action :authenticate_user!
end
