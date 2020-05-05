class RemoveTasksIdFromTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :tasks_id, :integer
  end
end
