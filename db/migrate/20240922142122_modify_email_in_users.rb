class ModifyEmailInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :email, :string, null: false, default: nil
    change_column_null :users, :name, false
    change_column_null :users, :phone_no, false
  end
end
