class AddToMaintenanceItems < ActiveRecord::Migration[5.1]
  def change
    change_table :maintenance_items do |t|
      t.integer :user_id
    end
  end
end
