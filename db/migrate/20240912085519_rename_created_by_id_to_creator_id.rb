class RenameCreatedByIdToCreatorId < ActiveRecord::Migration[7.0]
  def change
    rename_column :jobs, :created_by_id, :creater_id
  end
end
