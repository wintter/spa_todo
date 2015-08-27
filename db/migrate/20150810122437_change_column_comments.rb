class ChangeColumnComments < ActiveRecord::Migration
  def change
    rename_column :task_lists, :comments, :name
  end
end
