class PizzasController < ApplicationController
    before_action :set_pizza, only:[:show, :edit, :update]
    before_action :redirect_if_not_logged_in, except:[:new, :create]
  
    def new
      @pizza = Pizza.new
      @pizza.build_company
    end
  
    def create
       @pizza = Pizza.new(pizza_params)
       @pizza.user_id = session[:user_id]
       
     
      if @pizza.save
        redirect_to pizza_path(@pizza)
      else
        render :new
      end
    end
  
    def index
      @pizza = Pizza.all
    end
  
    def show
      @user = User.find(session[:user_id])
      @pizza = Pizza.find_by_id(params[:id])
      #byebug
      
    end
  
    def edit

    end
  
    def update
      if @pizza.update(pizza_params)
        redirect_to pizza_path(@pizza)
      else
        render :edit
      end
    end

    def mypizzas
      @user = User.find(session[:user_id])
    end

  
    private
  
    def pizza_params
      params.require(:pizza).permit(:name, :description, :company_id, company_attributes: [:name])
    end
  
    def set_pizza
       @pizza = Pizza.find_by(params[:id])
       redirect_to pizzas_path if !@pizza
    end
  
  end