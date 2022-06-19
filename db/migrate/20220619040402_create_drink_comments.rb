class CreateDrinkComments < ActiveRecord::Migration[6.1]
  def change
    create_table :drink_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :drink_id

      t.timestamps
    end
  end
end
