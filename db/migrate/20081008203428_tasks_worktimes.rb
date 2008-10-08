class TasksWorktimes < ActiveRecord::Migration
  def self.up
    create_table :tasks_worktimes, :id => false do |t|
      t.integer :task_id, :null => false
      t.integer :worktime_id, :null => false
    end
  end

  def self.down
    drop_table :tasks_worktimes
  end
end
