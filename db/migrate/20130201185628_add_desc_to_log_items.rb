class AddDescToLogItems < ActiveRecord::Migration
  def change
    add_column :log_items, :desc, :text
  end
end
