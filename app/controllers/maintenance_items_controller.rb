class MaintenanceItemsController < ApplicationController
		
    get '/maintenance_items' do
        if logged_in?
            @maintenance_items = MaintenanceItem.all
            erb :'/maintenance/maintenance_items'
        else
            redirect '/login'
        end
    end
    
end