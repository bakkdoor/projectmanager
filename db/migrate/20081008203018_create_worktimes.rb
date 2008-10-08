class CreateWorktimes < ActiveRecord::Migration
  def self.up
    create_table :worktimes do |t|
      t.integer :user_id
      t.datetime :start_time
      t.datetime :end_time
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :worktimes
  end
end
