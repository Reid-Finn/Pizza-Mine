module ReviewsHelper

    def display_header(review)
      if params[:pizza_id]
          content_tag(:h1, "Add a Review for #{review.pizza.name} -  #{review.pizza.company.name}")
      else
        content_tag(:h1, "Create a review")
      end
    end
  end