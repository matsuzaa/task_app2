class RenamePassColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :pass, :password_digest
  end
end
