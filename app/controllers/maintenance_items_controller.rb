class MaintenanceItemsController < ApplicationController
		
    get '/maintenance_items' do
        if logged_in?
            @maintenance_items = MaintenanceItem.all
            erb :'/maintenance/maintenance_items'
        else
            redirect '/login'
        end
    end

    get '/maintenance_items/new' do  
        if logged_in?
            @cars = current_user.cars
            erb :'/maintenance/create_maintenance_item'
        else
            redirect '/login'
        end
    end

    post '/maintenance_items' do  
        if params[:maintenance_name] == ""
            redirect '/maintenance_items/new'
        else
            # @car = Car.find_by_id(params[:car_id])
            @maintenance_item = MaintenanceItem.create(name: params[:maintenance_name])
            redirect "/maintenance_items/#{@maintenance_item.id}"
        end
    end

    get '/maintenance_items/:id' do  #You might want to make this a slug route
        # binding.pry
        if logged_in?
            @maintenance_item = MaintenanceItem.find_by_id(params[:id])
            erb :'/maintenance/show_maintenance_item'
        else
            redirect '/login'
        end
    end

    get '/maintenance_items/:id/edit' do
        if logged_in?
            # binding.pry
            # @cars = current_user.cars
            @maintenance_item = MaintenanceItem.find_by_id(params[:id])
            @cars = @maintenance_item.cars
            @car_id = @cars.ids
            @car = Car.find_by_id(@car_id)
            binding.pry
            @car_maintenance_item = CarMaintenanceItem.find_by_id(@maintenance_item)
            erb :'/maintenance/edit_maintenance_item'
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

    patch '/maintenance_items/:id' do
        if params[:maintenance_name] == ""
            redirect "/maintenance_items/#{params[:id]}/edit"
        else
            
            @car = Car.find_by_id(params[:car_id])
            #Need to change car.id to new id
            @maintenance_item = MaintenanceItem.find_by_id(params[:id])
            @maintenance_item.name = params[:maintenance_name]
            # @maintenance_item.mileage_performed = params[:mileage_performed]
            # @maintenance_item.mileage_due = params[:mileage_due]
            # @maintenance_item.cost = params[:cost]
            # @car.maintenance_items = @maintenance_item
            # binding.pry
            @maintenance_item.save
            @car.save
            redirect "/maintenance_items/#{@maintenance_item.id}"
        end
    end

    delete '/maintenance_items/:id/delete' do
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