# 初回のスタッフ名登録（localStorage に staff_id を保存する前段）
class StaffsController < ApplicationController
  # 名前入力画面
  # localStorage に staff_id があれば JS で /scan へ飛ばす
  def new
  end

  # 名前を受け取り Staff を作成（同じ名前なら既存を再利用）
  def create
    name = params[:name].to_s.strip

    if name.blank?
      flash.now[:alert] = "名前を入力してください"
      render :new, status: :unprocessable_entity
      return
    end

    @staff = current_user.staffs.find_or_create_by!(name: name)
    render :registered, status: :ok
  end
end
