TODO: 1) Change all '/:id' routes into slug routes
2) Make it so input values can use ',' Right now if I type 35,000 into the 'miles' portion it saves as 35
3) Validate users 
4) Make records persist and be linkable. i.e. if you click on oil change it will list the current maintenance but below it are a record of past maintenances performed and the date performed (need to add a date input on the forms and add a column through a migration of the db)
--------------------------------------------

Useful lessons:
1) Sinatra Complex forms associations
2) Active record associations in sinatra
3) Active record associations: Join tables
------------------------------

edit_car_maintenance_item 
lines 13-18

 <label>Choose the Maintenance:</label>
      <select name="maintenance_id" >
        <% @maintenance_items.all.each do |maintenance_item| %>
        <option value="<%=maintenance_item.id%>"><%=maintenance_item.name%></option>
        <% end %>
      </select>
------------------------------

When I edit a scheduled maintenance it causes the maintenance_item.name to turn to 'nil'

in the car_maint_controller:
@maintenance_item = MaintenanceItem.find_by_id(params[:id]) 
@car_maintenance_item = CarMaintenanceItem.find_by_id(params[:id])
-> need to figure out what to use instead of params[:id], the @maintenance_item and @car_maintenance_item don't use the same :id
try:
@maintenance_item = MaintenanceItem.find_by_id(@car_maintenance_item.maintenance_item_id)
-----------------------
having problems droping/resetting the DB