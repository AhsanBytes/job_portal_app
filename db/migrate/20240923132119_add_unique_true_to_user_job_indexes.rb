class AddUniqueTrueToUserJobIndexes < ActiveRecord::Migration[7.0]
  def change
    remove_index :user_jobs, :job_id
    remove_index :user_jobs, :user_id

    add_index :user_jobs, :job_id, unique: true
    add_index :user_jobs, :user_id, unique: true
  end
end
