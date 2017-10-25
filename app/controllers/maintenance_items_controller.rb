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
            # binding.pry
            #current_user.maintenance_items.create doesn't specify what car the maintenance belongs to, need to figure this out.
            @maintenance_item = current_user.maintenance_items.create(name: params[:maintenance_name], mileage_performed: params[:mileage_performed], mileage_due: params[:mileage_due], cost: params[:cost])
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
            if @maintenance_item.user_id == current_user.id 
                erb :'/maintenance/edit_maintenance_item'
            else
                redirect '/maintenances_items'
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
            @maintenance_item.mileage_performed = params[:mileage_performed]
            @maintenance_item.mileage_due = params[:mileage_due]
            @maintenance_item.cost = params[:cost]
            @maintenance_item.save
            redirect "/maintenance_items/#{@maintenance_item.id}"
        end
    end

    delete '/maintenance_items/:id/delete' do
        if logged_in?
            @maintenance_item = MaintenanceItem.find_by_id(params[:id])
            if @maintenance_item.user_id == current_user.id 
                @maintenance_item.delete
                redirect '/maintenance_items'
            else
                redirect '/maintenance_items'
            end
        else
            redirect '/login'
        end
    end
    
end