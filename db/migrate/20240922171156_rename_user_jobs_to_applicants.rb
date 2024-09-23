class RenameUserJobsToApplicants < ActiveRecord::Migration[7.0]
  def change
    rename_table :user_jobs, :applicants
  end
end
