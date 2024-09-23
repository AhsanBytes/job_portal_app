class RenameDepNametoName < ActiveRecord::Migration[7.0]
  def change
    rename_column :departments, :dep_name, :name
    change_column_null :departments, :name, false
  end
end
