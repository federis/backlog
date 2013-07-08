class SetCompleteDefaultToFalse < ActiveRecord::Migration
  def change
    change_column_default :log_items, :complete, :false
  end
end
