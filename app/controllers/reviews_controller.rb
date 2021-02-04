class ReviewsController < ApplicationController
  before_action :redirect_if_not_logged_in


  def new
    if @pizza = Pizza.find_by_id(params[:id])
      @review = @pizza.reviews.build
      byebug
    else
      @review = Review.new
    end
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to review_path(@review)
    else
      render :new
    end
  end

  def show
    @review = Review.find_by_id(params[:id])
  end

  def index
    #how i check if it's nested & a valid id
    if @pizza = Pizza.find_by_id(params[:pizza_id])
      #nested
      @reviews = @pizza.reviews
    else
      #it's not nested
      @reviews = Review.all
    end
  end

  private

  def review_params
      params.require(:review).permit(:pizza_id, :content, :stars, :title)
  end
end