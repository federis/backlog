class AddPositionSortIndexToLogItems < ActiveRecord::Migration
  def change
    add_index :log_items, [:log_id, :position], order: { position: :asc }
  end
end
