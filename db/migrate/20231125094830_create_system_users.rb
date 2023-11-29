class CreateSystemUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :system_users do |t|
      t.string :user_name
      t.string :password
      t.timestamps
    end
  end
end
