TODO: 
1)When editing car_maintenance_item the car drop down works but if you change the car it doesn't change the record
2) Merge car_maintenance_item branch into master 
3) Change sinatra-flash message background color
-------------------------------------------------------------------------------------------------------
Nice to Have:
1) Change all '/:id' routes into slug routes
2) Make it so input values can use ',' Right now if I type 35,000 into the 'miles' portion it saves as 35
3) Make records persist and be linkable. i.e. if you click on oil change it will list the current maintenance but below it are a record of past maintenances performed and the date performed (need to add a date input on the forms and add a column through a migration of the db)
-------------------------------------------------------------------------------------------------------
Useful lessons:
1) Sinatra Complex forms associations
2) Active record associations in sinatra
3) Active record associations: Join tables
-------------------------------------------------------------------------------------------------------
edit_car_maintenance_item 
lines 13-18

 <label>Choose the Maintenance:</label>
      <select name="maintenance_id" >
        <% @maintenance_items.all.each do |maintenance_item| %>
        <option value="<%=maintenance_item.id%>"><%=maintenance_item.name%></option>
        <% end %>
      </select>
-------------------------------------------------------------------------------------------------------
having problems droping/resetting the DB
  FIX: delete 'development.sqlite' and run 'rake db:migrate'
-------------------------------------------------------------------------------------------------------
When i create a new maintenance_item it also creates a new car_maintenance_item
  FIX: Changed when maintenance_item is related to a car, used to be when a new maintenance category(maintenance_item) was made, now it happens when maintenance is scheduled(car_maintenance_item).
-------------------------------------------------------------------------------------------------------
show_car_maintenance_item
line 18 

<% @@maintenance.each do |maintenance| %>
    <%= maintenance.mileage_performed %>
    <%= maintenance.mileage_due %>
    <%= maintenance.cost %>
<% end %>
-------------------------------------------------------------------------------------------------------
edit_maintenance_item
line 5
<label>Car: </label>
    <select name="car_id" >
        <% @cars.all.each do |car| %>
       <option value="<%=car.id%>"><%=car.name%></option>
        <% end %>
    </select> 
    <br/>
-------------------------------------------------------------------------------------------------------
maintenance_items_controller
Line 6
@car_maint_items = []
            #collect all car_maintenance_items for current users cars
            @cars.each do |car|
                @car_maint_items << car.car_maintenance_items
            end
            @maintenance_items = []
            #collect all the maintenance_items for view

            @car_maint_items.each do |maint_item|
                maint_item.each do |maint_item_id|
                    @maintenance_items << MaintenanceItem.find_by_id(maint_item_id.maintenance_item_id)
                end
            end