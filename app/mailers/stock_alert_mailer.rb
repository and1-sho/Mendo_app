class StockAlertMailer < ApplicationMailer
  # 施設の管理者向け：発注を促す
  def order_request(item, facility_admin)
    @item = item
    @facility_admin = facility_admin

    mail(
      to: facility_admin.email,
      subject: "【mendo発注依頼】#{item.name}の在庫が不足しています"
    )
  end

  # システム管理者向け：アラート発生の報告（ログ・実績用）
  def alert_report(item, facility_admin:, to:)
    @item = item
    @facility_admin = facility_admin
    @facility_name = facility_admin.email

    mail(
      to: to,
      subject: "【mendoログ】#{@facility_name}施設にて在庫アラートが発生しました"
    )
  end
end
