class User < ApplicationRecord
    has_many :reviews
    has_many :reviewed_pizzas, through: :reviews, source: :pizza
    has_many :pizzas
end
