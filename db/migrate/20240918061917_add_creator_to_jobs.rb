class AddCreatorToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :creator_id, :integer
    add_foreign_key :jobs, :users, column: :creator_id
    add_index :jobs, :creator_id
  end
end
