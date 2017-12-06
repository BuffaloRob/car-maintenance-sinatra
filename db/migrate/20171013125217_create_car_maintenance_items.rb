class CreateCarMaintenanceItems < ActiveRecord::Migration[5.1]
  def change
     create_table :car_maintenance_items do |t|
      t.integer :maintenance_item_id
      t.integer :car_id
    end
  end
end
