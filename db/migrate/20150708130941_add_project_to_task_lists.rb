class AddProjectToTaskLists < ActiveRecord::Migration
  def change
    add_reference :task_lists, :project, index: true, foreign_key: true
  end
end
