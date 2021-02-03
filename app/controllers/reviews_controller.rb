class ReviewsController < ApplicationController
    before_action :redirect_if_not_logged_in


    def new
      if @pizza = Pizza.find_by_id(params[:pizza_id])
        byebug
        @review = @pizza.reviews.build
      else
        @review = Review.new
      end
    end


    def index
    end


    def create
        @review = current_user.reviews.build(review_params)
        if @review.save
          redirect_to review_path(@review)
        else
          render :new
        end
      end


    private

    def set_pizza
       @pizza = Pizza.find_by_id(params[:pizza_id])
    end

end
