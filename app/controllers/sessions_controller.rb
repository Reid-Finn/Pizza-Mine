class SessionsController < ApplicationController
  #before_action :redirect_if_not_logged_in, except:[:new, :create, :welcome, :google]

    def welcome
      
    end

    def destroy
        session.clear
        redirect_to '/'
    end

    def new
    end
    
    def create

      #if params[:provider] == 'google_oauth2'
        #@user = User.create(auth)
        #session[:user_id] = @user.id
        #redirect_to user_path(@user)
      #else
  
        @user = User.find_by(username: params[:user][:username])
        if @user.try(:authenticate, params[:user][:password])
          session[:user_id] = @user.id
          redirect_to user_path(@user)
        else
          flash[:error] = "Sorry, login info was incorrect. Please try again."
          redirect_to login_path
        end
      #end
    end

    def omniauth  #log users in with omniauth
      #byebug
    user = User.find_or_create_by(email: auth['info']['email'], username: auth['info']['name']) do |u|
      #byebug
      u.password = SecureRandom.hex(10)
      #byebug

    end
    #byebug
    if user.save
        session[:user_id] = user.id
        redirect_to pizzas_path
    else
        flash[:message] = user.errors.full_messages.join(", ")
        redirect_to '/'
    end
end

private
def auth
    request.env['omniauth.auth']
end

  
  
  
end