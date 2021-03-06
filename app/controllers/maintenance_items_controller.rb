class MaintenanceItemsController < ApplicationController
		
    get '/maintenance_items' do
        if logged_in?
            @cars = current_user.cars
            
            @user_id = @cars.first.user_id

            @maintenance_items = MaintenanceItem.all
            @user_maintenance_items = []
            @maintenance_items.each do |item|
                if item.user_id == @user_id
                    @user_maintenance_items << item
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
            @maintenance_item = MaintenanceItem.create(name: params[:maintenance_name], user_id: current_user.id)
            redirect "/maintenance_items/#{@maintenance_item.id}"
        end
    end

    get '/maintenance_items/:id' do  
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
        else
            redirect '/login'
        end
    end 
    
end