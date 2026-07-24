class AddBarcodeToItems < ActiveRecord::Migration[7.1]
  def change
    # 商品に付いているバーコード（商品番号 item_code とは別）
    add_column :items, :barcode, :string
    add_index :items, :barcode, unique: true
  end
end
