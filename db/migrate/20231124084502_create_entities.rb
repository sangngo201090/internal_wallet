class CreateEntities < ActiveRecord::Migration[7.1]
  def change
    create_table :entities do |t|
      t.references :wallet, foreign_key: true, unique: true, dependent: :destroy
      t.references :system_user, foreign_key: true, unique: true, dependent: :destroy
      t.string :type
      # common attributes
      t.string :name
      # attributes for user
      t.date :birth_date
      # attributes for team and stock
      t.string :description
      # attributes for stock
      t.string :symbol

      t.timestamps
    end
  end
end
