class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.integer :customer_id
      t.string :name
      t.date :due_date
      t.boolean :finished

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
