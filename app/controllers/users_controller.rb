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

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id 
            redirect '/cars'
        else
            flash[:notice] = "That is not a valid user"
            redirect '/signup'
        end
    end

    get '/signup' do
        if !logged_in?
            erb :'/users/create_user'
        else
            redirect '/cars'
            flash[:notice] = "You're already signed in"
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            flash[:message] = "Don't leave any fields blank"
            redirect '/signup'
        else
            @user = User.create(username: params[:username], email: params[:email], password: params[:password])
            @user.save
            session[:user_id] == @user.id
            redirect '/cars'
        end

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