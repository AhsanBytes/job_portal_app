class RenameApplicantsToUserJobs < ActiveRecord::Migration[7.0]
  def change
    rename_table :applicants, :user_jobs
  end
end
