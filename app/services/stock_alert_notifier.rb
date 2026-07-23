# 在庫が注文トリガー数以下になった瞬間にメールを送る
class StockAlertNotifier
  def initialize(item:, previous_stock:, admin_user:)
    @item = item
    @previous_stock = previous_stock
    @facility_admin = admin_user
  end

  def call
    return unless threshold_crossed?

    # メール失敗で在庫記録全体を落とさない（本番で SMTP 未設定のときなど）
    begin
      # ① 施設の管理者へ発注依頼
      StockAlertMailer.order_request(@item, @facility_admin).deliver_now

      # ② ①が成功したあとだけ、システム管理者へ発生報告を送る
      send_system_admin_report if system_admin_email.present?
    rescue StandardError => e
      Rails.logger.error("[StockAlertNotifier] mail failed: #{e.class}: #{e.message}")
    end
  end

  private

  # トリガー数を「下回った瞬間」だけ true（毎回送らない）
  def threshold_crossed?
    @previous_stock > @item.order_trigger && @item.stock <= @item.order_trigger
  end

  def system_admin_email
    ENV["SYSTEM_ADMIN_EMAIL"].presence
  end

  def send_system_admin_report
    StockAlertMailer.alert_report(
      @item,
      facility_admin: @facility_admin,
      to: system_admin_email
    ).deliver_now
  end
end
