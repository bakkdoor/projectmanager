class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.integer :project_id, :null => false
      t.integer :parent_id
      t.string :name
      t.text :comment
      t.integer :status
      t.date :due_date

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
