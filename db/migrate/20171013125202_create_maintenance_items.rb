class CreateMaintenanceItems < ActiveRecord::Migration[5.1]
  def change
     create_table :maintenance_items do |t|
      t.string :name
      t.integer :mileage_performed
      t.integer :mileage_due
      t.integer :cost

      t.timestamps
    end
  end
end
