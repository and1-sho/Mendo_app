# 管理画面からの入庫（在庫を増やし、履歴にプラスを残す）
class ItemStockReceipt
  ADMIN_STAFF_NAME = "管理者"

  def initialize(user:, item:, quantity:)
    @user = user
    @item = item
    @quantity = quantity.to_i
  end

  def call
    return failure("個数を入力してください") if @quantity <= 0

    staff = @user.staffs.find_or_create_by!(name: ADMIN_STAFF_NAME)

    ActiveRecord::Base.transaction do
      item = Item.lock.find(@item.id)
      item.update!(stock: item.stock + @quantity)
      StockHistory.create!(item: item, staff: staff, quantity: @quantity)
      @item = item
    end

    {
      success: true,
      message: "#{@quantity}個入庫しました（現在の在庫: #{@item.stock}）"
    }
  rescue ActiveRecord::RecordInvalid => e
    failure(e.record.errors.full_messages.to_sentence)
  end

  private

  def failure(message)
    { success: false, message: message }
  end
end
