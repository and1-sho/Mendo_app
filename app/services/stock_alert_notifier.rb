# 在庫が注文トリガー数以下になった瞬間にメールを送る
class StockAlertNotifier
  def initialize(item:, previous_stock:, admin_user:)
    @item = item
    @previous_stock = previous_stock
    @admin_user = admin_user
  end

  def call
    return unless threshold_crossed?

    # メール失敗で在庫記録全体を落とさない（本番で SMTP 未設定のときなど）
    begin
      StockAlertMailer.admin_alert(@item, @admin_user).deliver_now
      send_owner_mail if owner_email.present?
    rescue StandardError => e
      Rails.logger.error("[StockAlertNotifier] mail failed: #{e.class}: #{e.message}")
    end
  end


  private

  # トリガー数を「下回った瞬間」だけ true（毎回送らない）
  def threshold_crossed?
    @previous_stock > @item.order_trigger && @item.stock <= @item.order_trigger
  end

  def owner_email
    ENV["OWNER_EMAIL"].presence
  end

  def send_owner_mail
    StockAlertMailer.owner_order_request(@item, to: owner_email).deliver_now
  end
end
