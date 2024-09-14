class RenameCreaterIdToCreatorId < ActiveRecord::Migration[7.0]
  def change
    rename_column :jobs,:creater_id, :creator_id
  end
end
