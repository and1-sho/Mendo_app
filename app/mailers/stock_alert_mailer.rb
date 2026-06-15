class StockAlertMailer < ApplicationMailer
  # 施設管理者（admin）向け：在庫が少なくなったことを知らせる
  def admin_alert(item, admin_user)
    @item = item
    @admin_user = admin_user

    mail(
      to: admin_user.email,
      subject: "【在庫アラート】#{item.name} の在庫が少なくなりました"
    )
  end

  # オーナー（システム作成者）向け：発注を依頼する
  def owner_order_request(item, to:)
    @item = item

    mail(
      to: to,
      subject: "【発注依頼】#{item.name} を #{item.order_quantity} 個注文してください"
    )
  end
end