require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    erb :signup
  end

  post "/signup" do
    if params[:username] == "" || params[:password] == ""
      redirect :'/failure'
    else
      User.create(username: params[:username], password: params[:password])
      redirect :'/login'
    end
  end

  get "/login" do
    erb :login
  end

  post "/login" do
    if params[:username] == "" || params[:password] == ""
      redirect :'/failure'
    else
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect :'/account'
      else
        redirect :'/failure'
      end
    end
  end

  get '/account' do
    @user = current_user
    erb :account
  end


  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  # not being used
  get "/success" do
    if logged_in?
      erb :success # not implemented
    else
      redirect "/login"
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
