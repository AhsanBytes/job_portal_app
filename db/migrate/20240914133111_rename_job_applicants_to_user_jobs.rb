class RenameJobApplicantsToUserJobs < ActiveRecord::Migration[7.0]
  def change
    rename_table :job_applicants, :user_jobs
  end
end
