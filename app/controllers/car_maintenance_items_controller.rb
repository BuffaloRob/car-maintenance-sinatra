class CarMaintenanceItemsController < ApplicationController

    # @@maintenance = []	
    
    get '/car_maintenance_items' do
        if logged_in?
            @maintenance_items = MaintenanceItem.all
            erb :'/car_maintenance/car_maintenance_item'
        else
            redirect '/login'
        end
    end

    get '/car_maintenance_items/new' do  
        if logged_in?
            @cars = current_user.cars
            @maintenance_items = MaintenanceItem.all
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
            @car = Car.find_by_id(params[:id])
            @car_maintenance_item = CarMaintenanceItem.find_by_id(params[:id])
            # @@maintenance << @car_maintenance_item
            @maintenance_item = MaintenanceItem.find_by_id(@car_maintenance_item.maintenance_item_id)
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
                redirect '/car_maintenances_items'
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