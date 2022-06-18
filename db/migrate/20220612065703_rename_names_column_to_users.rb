class RenameNamesColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :names, :name
  end
end
