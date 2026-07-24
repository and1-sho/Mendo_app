# バーコードスキャンで在庫を1減らし、履歴を残す
class ItemBarcodeScanner
  def initialize(user:, barcode:, staff_id:)
    @user = user
    @barcode = barcode.to_s.strip
    @staff_id = staff_id
  end

  def call
    return failure("バーコードを入力してください") if @barcode.blank?

    staff = @user.staffs.find_by(id: @staff_id)
    return failure("スタッフが登録されていません") unless staff

    item = Item.find_by(barcode: @barcode)
    return failure("備品が見つかりませんでした") unless item
    return failure("在庫がありません") if item.stock <= 0

    previous_stock = item.stock

    ActiveRecord::Base.transaction do
      item.update!(stock: previous_stock - 1)
      StockHistory.create!(item: item, staff: staff, quantity: -1)
    end

    StockAlertNotifier.new(
      item: item,
      previous_stock: previous_stock,
      admin_user: @user
    ).call

    {
      success: true,
      message: "記録しました",
      item: {
        id: item.id,
        name: item.name,
        item_code: item.item_code,
        barcode: item.barcode,
        stock: item.stock
      }
    }
  end

  private

  def failure(message)
    { success: false, message: message }
  end
end
