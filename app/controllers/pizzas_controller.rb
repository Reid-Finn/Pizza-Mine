class PizzasController < ApplicationController
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
    end

    private
    
    def pizza_params
        params.require(:pizza).permit(:name, :description, :company_id, company_attributes: [:name])
    end
end
