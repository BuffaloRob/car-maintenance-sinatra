class CarsController < ApplicationController

# TODO:Make it so :slug will work on duplicate name

    get '/cars' do 
        if logged_in?
            @cars = current_user.cars
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
        if params[:car_name] == ""
            redirect '/cars/new'
        else
            @car = current_user.cars.create(name: params[:car_name])
            redirect "/cars/#{@car.id}"
        end
    end

    get '/cars/:id' do # You might want to make this a slug route
        if logged_in?
            @car = Car.find_by_id(params[:id])
            binding.pry
            
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
        if params[:car_name] == ""
            redirect "/cars/#{params[:id]}/edit"
        else
            @car = Car.find_by_id(params[:id])
            @car.name = params[:car_name]
            @car.save
            redirect "/cars/#{@car.id}"
        end
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