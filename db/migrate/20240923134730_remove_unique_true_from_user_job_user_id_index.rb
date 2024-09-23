class RemoveUniqueTrueFromUserJobUserIdIndex < ActiveRecord::Migration[7.0]
  def change
    remove_index :user_jobs, :user_id

    add_index :user_jobs, :user_id
  end
end
