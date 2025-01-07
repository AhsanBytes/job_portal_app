class AddMultipleColumnUniqueIndexesToUserJobs < ActiveRecord::Migration[7.0]
  def change
    add_index :user_jobs, [:user_id, :job_id], name: "index_user_jobs_uniqueness", unique: true
  end
end
