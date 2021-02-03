class ReviewsController < ApplicationController

    def new
        @pizza = Pizza.find_by_id(params[:id])
        @review = @pizza.build_review
    end

    def index
    end

end
