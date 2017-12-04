class MaintenanceItemsController < ApplicationController
		
    get '/maintenance_items' do
        if logged_in?
            @cars = current_user.cars
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
            @maintenance_item = MaintenanceItem.create(name: params[:maintenance_name])
            redirect "/maintenance_items/#{@maintenance_item.id}"
        end
    end

    get '/maintenance_items/:id' do  #You might want to make this a slug route
        if logged_in?
            @maintenance_item = MaintenanceItem.find_by_id(params[:id])
            erb :'/maintenance/show_maintenance_item'
        else
            redirect '/login'
        end
    end

    get '/maintenance_items/:id/edit' do
        if logged_in?
            @maintenance_item = MaintenanceItem.find_by_id(params[:id])
            @cars = @maintenance_item.cars #produces array of cars
            @car_id = @cars.ids
            @car = Car.find_by_id(@car_id)
            # binding.pry
            ##### Need a more robust solution than the one below. if the maintenance item hasn't been scheduled for maintenance then there will NOT be a car associated with it, therefor @car.user_id causes an error
            if @car == nil || current_user.id == @car.user_id 
                erb :'/maintenance/edit_maintenance_item'
            else
                redirect '/maintenance_items'
            end
        else
            redirect '/login'
        end
    end

    patch '/maintenance_items/:id' do
        if params[:maintenance_name] == ""
            redirect "/maintenance_items/#{params[:id]}/edit"
        else
            @maintenance_item = MaintenanceItem.find_by_id(params[:id])
            @maintenance_item.name = params[:maintenance_name]
            @maintenance_item.save
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