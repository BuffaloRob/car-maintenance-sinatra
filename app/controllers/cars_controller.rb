class CarsController < ApplicationController
		
    get '/cars' do 
        if logged_in?
            @cars = Cars.all
            erb :'/cars/cars'
        else
            redirect '/login'
        end
    end

    get '/cars/new' do
        if logged_in?
            erb :'/cars/create_car'
        else
            redirect '/login'
        end
    end

    post '/cars' do
    
    end

    get '/cars/:id' do
        if logged_in?
            @car = Car.find_by_id(params[:id])
            erb :'/cars/show_car'
        else
            redirect '/login'
        end
    end

    get '/cars/:id/edit' do
        if logged_in?
            @car = Car.find_by_id(params[:id])
            if @car.user_id == current_user.id 
                erb :'/cars/edit_car'
            else
                redirect '/cars'
            end
        else
            redirect '/login'
        end
    end

    patch '/cars/:id' do 

    end

    delete '/cars/:id/delete' do  
        if logged_in?
            @car = Car.find_by_id(params[:id])
            if @car.user_id == current_user.id
                @car.delete
                redirect '/cars'
            else
                redirect '/cars'
            end
        else
            redirect '/login'
        end
    end

end