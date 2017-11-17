class AlterCarMaintenanceItems < ActiveRecord::Migration[5.1]
  def change
    change_table :car_maintenance_items do |t|
      t.integer :mileage_performed
      t.integer :mileage_due
      t.integer :cost
    end
  end
end
