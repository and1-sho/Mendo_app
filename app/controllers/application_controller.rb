class ApplicationController < ActionController::Base
  # 全画面でログインを必須にする
  # ログインしていない場合はログイン画面にリダイレクトされる
  before_action :authenticate_user!

  private

  # ログイン成功後はスタッフ名登録画面へ
  # （localStorage に staff_id があれば JS で /scan へ進む）
  def after_sign_in_path_for(_resource)
    new_staff_path
  end
end
