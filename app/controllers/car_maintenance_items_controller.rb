class CarMaintenanceItemsController < ApplicationController
		
    get '/car_maintenance_items' do
        # binding.pry
        if logged_in?
            @car_maintenance_items = CarMaintenanceItem.all
            erb :'/car_maintenance/car_maintenance_items'
        else
            redirect '/login'
        end
    end

    get '/car_maintenance_items/new' do  
        if logged_in?
            @cars = current_user.cars
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
            @car_maintenance_item = @car.car_maintenance_items.create(mileage_performed: params[:mileage_performed], mileage_due: params[:mileage_due], cost: params[:cost])
            redirect "/car_maintenance_items/#{@car_maintenance_item.id}"
        end
    end

    get '/car_maintenance_items/:id' do  #You might want to make this a slug route
        # binding.pry
        if logged_in?
            @car_maintenance_item = CarMaintenanceItem.find_by_id(params[:id])
            erb :'/car_maintenance/show_car_maintenance_item'
        else
            redirect '/login'
        end
    end

    get '/car_maintenance_items/:id/edit' do
        if logged_in?
            # binding.pry
            @cars = current_user.cars
            @car_maintenance_item = CarMaintenanceItem.find_by_id(params[:id])
            erb :'/car_maintenance/edit_car_maintenance_item'
            #### DO I NEED TO VALIDATE HERE???? Need to do it a different way, similar to the 'post "/maintenance_items"' route
            # if @maintenance_item.user_id == current_user.id 
            #     erb :'/maintenance/edit_maintenance_item'
            # else
            #     redirect '/maintenances_items'
            # end
        else
            redirect '/login'
        end
    end

    patch '/car_maintenance_items/:id' do
        if params[:maintenance_name] == ""
            redirect "/maintenance_items/#{params[:id]}/edit"
        else
            
            @car = Car.find_by_id(params[:car_id])
            #Need to change car.id to new id
            @maintenance_item = MaintenanceItem.find_by_id(params[:id])
            @maintenance_item.name = params[:maintenance_name]
            @maintenance_item.mileage_performed = params[:mileage_performed]
            @maintenance_item.mileage_due = params[:mileage_due]
            @maintenance_item.cost = params[:cost]
            # @car.maintenance_items = @maintenance_item
            # binding.pry
            @maintenance_item.save
            @car.save
            redirect "/maintenance_items/#{@maintenance_item.id}"
        end
    end

    delete '/car_maintenance_items/:id/delete' do
        if logged_in?
            @maintenance_item = MaintenanceItem.find_by_id(params[:id])
            @maintenance_item.delete
            redirect '/maintenance_items'
            ####Same issue as line 46
            # if @maintenance_item.user_id == current_user.id 
            #     @maintenance_item.delete
            #     redirect '/maintenance_items'
            # else
            #     redirect '/maintenance_items'
            # end
        else
            redirect '/login'
        end
    end 
    
end