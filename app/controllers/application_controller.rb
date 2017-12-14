require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  enable :sessions
  register Sinatra::Flash

  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }
  set :public_folder, Proc.new { File.join(root, "../public/") }

  get '/' do
    erb :'/index'
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

  end

end
