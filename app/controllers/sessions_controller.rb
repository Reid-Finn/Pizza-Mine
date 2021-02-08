class SessionsController < ApplicationController
  before_action :redirect_if_not_logged_in, except:[:new, :create, :welcome, :google]

    def welcome
      
    end

    def destroy
        session.delete(:user_id)
        redirect_to '/'
    end

    def new
    end
    
    def create

      if params[:provider] == 'google_oauth2'
        @user = User.create_by_google_omniauth(auth)
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
  
        @user = User.find_by(username: params[:user][:username])
        if @user.try(:authenticate, params[:user][:password])
          session[:user_id] = @user.id
          redirect_to user_path(@user)
        else
          flash[:error] = "Sorry, login info was incorrect. Please try again."
          redirect_to login_path
        end
      end
    end

    def google
     
      @user= User.find_or_create_by(email: request.env["omniauth.auth"]["info"]["email"], username: request.env["omniauth.auth"]["info"]["first_name"]) do |user|
        user.password = SecureRandom.hex(10)
      end
      if @user && @user.id
        session[:user_id] = @user.id
     
        redirect_to pizzas_path
      else
        render :new
      end
    end
  
  
  
  end