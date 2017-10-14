class UsersController < ApplicationController
		
    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end

    get '/login' do
        if !logged_in?
            erb :'/users/login'
        else
            redirect '/cars'
        end
    end

    post '/signup' do

    end

    get '/signup' do
        if !logged_in?
            erb :'/users/create_user'
        else
            redirect '/cars'
        end
    end

    post '/signup' do

    end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect '/login'
        else
            redirect '/'
        end
    end
    
end