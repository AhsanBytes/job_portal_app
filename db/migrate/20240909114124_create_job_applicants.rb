class CreateJobApplicants < ActiveRecord::Migration[7.0]
  def change
    create_table :job_applicants do |t|
      t.references :job, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
