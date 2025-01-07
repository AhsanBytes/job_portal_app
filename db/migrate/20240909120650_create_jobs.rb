class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.string :company
      t.integer :work_space_type
      t.string :location
      t.string :lead_source
      t.boolean :active, default: true
      t.integer :created_by_id, null: false
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end

    add_foreign_key :jobs, :users, column: :created_by_id
  end
end
