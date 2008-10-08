class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :name
      t.string :street
      t.string :house_nr
      t.integer :zip_code
      t.string :city
      t.string :telephone
      t.string :email
      t.string :contact
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end
