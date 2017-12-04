class CarMaintenanceItemsController < ApplicationController

    # @@maintenance = []	
    
    get '/car_maintenance_items' do
        if logged_in?
            @cars = current_user.cars
            @car_maint_items = []
            #collect all car_maintenance_items for current users cars
            @cars.each do |car|
                @car_maint_items << car.car_maintenance_items
            end

            if @car_maint_items.any? {|i| i.empty?}
                @maintenance_items = MaintenanceItem.all
                erb :'/car_maintenance/car_maintenance_item'

            else
                @maintenance_items = []
                #collect all the maintenance_items for display/links
                @car_maint_items.each do |maint_item_id|
                    @maintenance_items << MaintenanceItem.find_by_id(maint_item_id)
                end
     # binding.pry
            end
            erb :'/car_maintenance/car_maintenance_item'
        else
            redirect '/login'
        end
    end

    get '/car_maintenance_items/new' do  
        if logged_in?
            @cars = current_user.cars
            @car_maint_items = []
            #collect all car_maintenance_items for current users cars
            @cars.each do |car|
                @car_maint_items << car.car_maintenance_items
            end

            if @car_maint_items.all? {|i| i.empty?}
                @maintenance_items = MaintenanceItem.all
                erb :'/car_maintenance/create_car_maintenance_item'
            else
                @maintenance_items = []
                #collect all the maintenance_items for use in the drop down to choose a maintenance category
                @car_maint_items.each do |maint_item|
                    maint_item.each do |maint_item_id|
                        @maintenance_items << MaintenanceItem.find_by_id(maint_item_id.maintenance_item_id)
                    end
                    
                ### Are the below values in the array considered key value pairs???
                #[[#<CarMaintenanceItem:0x007fffd0f073f0 id: 6, maintenance_item_id: 9, car_id: 5, mileage_performed: 35000, mileage_due: 44000, cost: 15>]]
                end
            end
            erb :'/car_maintenance/create_car_maintenance_item'
        else
            redirect '/login'
        end
    end

    post '/car_maintenance_items' do  
        if params[:maintenance_name] == ""
            redirect '/car_maintenance_items/new'
        else
            @car = Car.find_by_id(params[:car_id])
            @car_maintenance_item = @car.car_maintenance_items.create(mileage_performed: params[:mileage_performed], mileage_due: params[:mileage_due], cost: params[:cost], maintenance_item_id: params[:maintenance_id])
            redirect "/car_maintenance_items/#{@car_maintenance_item.id}"
        end
    end

    get '/car_maintenance_items/:id' do  #You might want to make this a slug route
        if logged_in?
            @car_maintenance_item = CarMaintenanceItem.find_by_id(params[:id])
            # @@maintenance << @car_maintenance_item
            @maintenance_item = MaintenanceItem.find_by_id(@car_maintenance_item.maintenance_item_id)
            @car = Car.find_by_id(@car_maintenance_item.car_id)
            # binding.pry
            erb :'/car_maintenance/show_car_maintenance_item'
        else
            redirect '/login'
        end
    end

    get '/car_maintenance_items/:id/edit' do
        if logged_in?
            @cars = current_user.cars
            @car_maintenance_item = CarMaintenanceItem.find_by_id(params[:id])
            @maintenance_item = MaintenanceItem.find_by_id(@car_maintenance_item.maintenance_item_id)
            if current_user.id == @car_maintenance_item.car.user.id
                erb :'/car_maintenance/edit_car_maintenance_item'
            else
                redirect '/car_maintenance_items'
            end
        else
            redirect '/login'
        end
    end

    patch '/car_maintenance_items/:id' do
        if params[:maintenance_name] == ""
            redirect "/car_maintenance_items/#{params[:id]}/edit"
        else
            @car = Car.find_by_id(params[:car_id])
            @car_maintenance_item = CarMaintenanceItem.find_by_id(params[:id])
            @car_maintenance_item.mileage_performed = params[:mileage_performed]
            @car_maintenance_item.mileage_due = params[:mileage_due]
            @car_maintenance_item.cost = params[:cost]
            @maintenance_item = MaintenanceItem.find_by_id(@car_maintenance_item.maintenance_item_id)
            @car.save
            @maintenance_item.save
            @car_maintenance_item.save
            
            redirect "/car_maintenance_items/#{@car_maintenance_item.id}"
        end
    end

    delete '/car_maintenance_items/:id/delete' do
        if logged_in?
            @car_maintenance_item = CarMaintenanceItem.find_by_id(params[:id])     
            if current_user.id == @car_maintenance_item.car.user.id
                @car_maintenance_item.delete
                redirect '/car_maintenance_items'
            else
                redirect '/car_maintenance_items'
            end
        else
            redirect '/login'
        end
    end 
    
end