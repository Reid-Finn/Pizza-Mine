class CompaniesController < ApplicationController

    def index
        @companies = Company.all
    end

    def search  
        if params[:search].blank?  
          redirect_to(companies_path, error: "Empty field!") and return  
        else  
          @parameter = params[:search].downcase
          @company = Company.find_by("name LIKE :search", search: @parameter)
          @pizza = Pizza.select{ |p| p[:company_id] == @company.id}
        
        end  
      end
end
