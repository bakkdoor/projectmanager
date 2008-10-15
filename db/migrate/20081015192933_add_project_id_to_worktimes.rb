class AddProjectIdToWorktimes < ActiveRecord::Migration
  def self.up
    add_column :worktimes, :project_id, :integer
  end

  def self.down
    remove_column :worktimes, :project_id
  end
end
