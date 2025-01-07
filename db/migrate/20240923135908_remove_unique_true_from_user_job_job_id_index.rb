class RemoveUniqueTrueFromUserJobJobIdIndex < ActiveRecord::Migration[7.0]
  def change
    remove_index :user_jobs, :job_id

    add_index :user_jobs, :job_id
  end
end
