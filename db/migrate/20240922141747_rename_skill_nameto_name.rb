class RenameSkillNametoName < ActiveRecord::Migration[7.0]
  def change
    rename_column :skills, :skill_name, :name
    change_column_null :skills, :name, false
  end
end
