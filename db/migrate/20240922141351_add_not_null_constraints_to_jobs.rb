class AddNotNullConstraintsToJobs < ActiveRecord::Migration[7.0]
  def change
    change_column_null :jobs, :title, false
    change_column_null :jobs, :company, false
    change_column_null :jobs, :work_space_type, false
    change_column_null :jobs, :location, false
    change_column_null :jobs, :lead_source, false
    change_column_null :jobs, :creator_id, false
  end
end
