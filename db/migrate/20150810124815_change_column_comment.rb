class ChangeColumnComment < ActiveRecord::Migration
  def change
    rename_column :comments, :comment, :name
  end
end
