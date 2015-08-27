class CreateTaskLists < ActiveRecord::Migration
  def change
    create_table :task_lists do |t|
      t.datetime :deadline
      t.boolean :status
      t.text :comments
      t.string :filename

      t.timestamps null: false
    end
  end
end
