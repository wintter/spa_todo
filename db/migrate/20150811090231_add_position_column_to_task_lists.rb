class AddPositionColumnToTaskLists < ActiveRecord::Migration
  def change
    add_column :task_lists, :position, :string
  end
end
