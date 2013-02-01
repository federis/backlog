class CreateLogItems < ActiveRecord::Migration
  def change
    create_table :log_items do |t|
      t.references :log
      t.references :user
      t.integer :position
      t.string :content
      t.boolean :milestone
      t.boolean :complete

      t.timestamps
    end
    add_index :log_items, :log_id
    add_index :log_items, :user_id
  end
end
