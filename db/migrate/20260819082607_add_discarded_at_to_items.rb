class AddDiscardedAtToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :discarded_at, :datetime
    add_index :items, :discarded_at
  end
end
