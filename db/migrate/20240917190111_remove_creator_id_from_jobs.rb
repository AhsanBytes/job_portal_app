class RemoveCreatorIdFromJobs < ActiveRecord::Migration[7.0]
  def change
    remove_column :jobs, :creator_id, :integer
  end
end
