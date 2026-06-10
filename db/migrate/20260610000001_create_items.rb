class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      # 商品番号（スタッフがテンキーで入力する番号）
      # unique: 重複禁止、null: false: 必須
      t.integer :item_code, null: false

      # 備品名
      t.string :name, null: false

      # 現在の在庫数（初期値は0）
      t.integer :stock, null: false, default: 0

      # 注文トリガー数（この数以下になったら発注のサイン）
      t.integer :order_trigger, null: false

      # 目標補充数（目標補充数 - 現在の在庫数 = 今回の発注量）
      t.integer :reorder_quantity, null: false

      t.timestamps
    end

    # 商品番号に一意インデックスを追加（重複登録を DB レベルでも防ぐ）
    add_index :items, :item_code, unique: true
  end
end
