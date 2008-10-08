class TasksUsers < ActiveRecord::Migration
  def self.up
    create_table :tasks_users, :id => false do |t|
      t.integer :task_id, :null => false
      t.integer :user_id, :null => false
    end
  end

  def self.down
    drop_table :tasks_users
  end
end
