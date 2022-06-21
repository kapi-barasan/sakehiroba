class CreateDrinks < ActiveRecord::Migration[6.1]
  def change
    create_table :drinks do |t|
      t.integer :user_id
      t.string :name
      t.text :body
      t.float :rate
      t.timestamps
    end
  end
end
