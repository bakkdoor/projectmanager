class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                     :string, :limit => 40
      t.column :name,                      :string, :limit => 100, :default => '', :null => true
      t.column :email,                     :string, :limit => 100
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string, :limit => 40
      t.column :remember_token_expires_at, :datetime
      
      # custom settings
      t.column :icq_im, :string
      t.column :jabber, :string
      
      t.column :telephone, :string
      t.column :street, :string
      t.column :house_nr, :string
      t.column :zip_code, :integer
      t.column :city, :string
      
      t.column :birthdate, :date
      t.column :comment, :text
      t.column :is_admin, :boolean, :default => false      

    end
    add_index :users, :login, :unique => true
  end

  def self.down
    drop_table "users"
  end
end
