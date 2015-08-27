class AddTaskListsRefToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :task_list, index: true, foreign_key: true
  end
end
