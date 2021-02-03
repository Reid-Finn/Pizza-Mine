class PizzasController < ApplicationController
    before_action :set_pizza, only:[:show, :edit, :update]
    before_action :redirect_if_not_logged_in
  
    def new
      @pizza = Pizza.new
      @pizza.build_company
    end
  
    def create
       @pizza = Pizza.new(pizza_params)
       @pizza.user_id = session[:user_id]
  
      if @pizza.save #this is where validations happen
        @pizza.image.purge
        @pizza.image.attach(params[:pizza][:image])
        redirect_to pizza_path(@pizza)
      else
        @pizza.build_company
        render :new
      end
    end
  
    def index
      @pizza = Pizza.order_by_rating.includes(:company)
    end
  
    def show
    end
  
    def edit
    end
  
    def update
      if @pizza.update(pizza_params)
        @pizza.image.purge
        @pizza.image.attach(params[:pizza][:image])
        redirect_to pizza_path(@pizza)
      else
        render :edit
      end
    end
  
    private
  
    def pizza_params
      params.require(:pizza).permit(:description, :company_id, company_attributes: [:name])
    end
  
    def set_pizza
       @pizza = Pizza.find_by(params[:id])
       redirect_to pizzas_path if !@pizza
    end
  
  end