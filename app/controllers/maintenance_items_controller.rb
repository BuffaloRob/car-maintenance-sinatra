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
            erb :'/maintenance/create_maintenance_item'
        else
            redirect '/login'
        end
    end

    post '/maintenance_items' do  

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