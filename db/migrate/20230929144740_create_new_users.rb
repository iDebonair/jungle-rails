class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
  
  def down
    # If you want to rollback the migration, you can specify how here
    drop_table :users, if_exists: true
  end
end
