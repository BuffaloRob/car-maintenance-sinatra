class UsersController < ApplicationController
		
    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end

    get '/login' do
        if !logged_in?
            erb :'/users/login'
        else
            flash[:notice] = "You're already logged in"
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
            flash[:notice] = "You're already signed up"
            redirect '/cars'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            flash[:notice] = "Don't leave any fields blank"
            redirect '/signup'
        end

        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        if @user.save
            session[:user_id] = @user.id
            redirect '/cars'
        else 
            flash[:notice] = "Trouble saving the account, please try again!"
            redirect '/signup'
        end
    end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect '/login'
        else
            flash[:notice] = "You're not logged in"
            redirect '/'
        end
    end

end