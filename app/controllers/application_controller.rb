class ApplicationController < ActionController::Base
  # 全画面でログインを必須にする
  # ログインしていない場合はログイン画面にリダイレクトされる
  before_action :authenticate_user!

  private

  # ログイン成功後はトップ（スキャン）へ
  # staff_id がなければスキャン画面の JS が名前登録へ送る
  def after_sign_in_path_for(_resource)
    root_path
  end
end
