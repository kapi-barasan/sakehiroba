class CreateDrinkTags < ActiveRecord::Migration[6.1]
  def change
    create_table :drink_tags do |t|
      t.integer :drink_id
      t.integer :tag_id

      t.timestamps
    end
      add_index :drink_tags, [:drink_id,:tag_id],unique: true
  end
end
