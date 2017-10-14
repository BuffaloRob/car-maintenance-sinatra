class AlterUsersTable < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.remove :name
      t.string :username
      t.string :email
      t.string :password_digest
    end
  end
end
