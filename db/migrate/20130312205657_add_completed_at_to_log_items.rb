class AddCompletedAtToLogItems < ActiveRecord::Migration
  def change
    add_column :log_items, :completed_at, :datetime
    remove_column :log_items, :complete
    add_index :log_items, :completed_at
  end
end
