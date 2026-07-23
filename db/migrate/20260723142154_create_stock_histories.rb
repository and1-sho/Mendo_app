class CreateStockHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :stock_histories do |t|
      t.references :item, null: false, foreign_key: true
      t.references :staff, null: false, foreign_key: true
      t.integer :quantity, null: false

      # created_at で操作日時を記録する（updated_at も Rails 標準として持たせる）
      t.timestamps
    end

    add_index :stock_histories, :created_at
  end
end
