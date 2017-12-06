class AlterMaintenanceItems < ActiveRecord::Migration[5.1]
  def change
    change_table :maintenance_items do |t|
      t.remove :cost
      t.remove :mileage_performed
      t.remove :mileage_due
    end
  end
end
