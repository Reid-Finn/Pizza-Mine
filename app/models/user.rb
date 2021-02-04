class User < ApplicationRecord
    has_many :reviews
    has_many :reviewed_pizzas, through: :reviews, source: :pizza
    has_many :pizzas

    has_secure_password
    #validates :username, uniqueness: true, presence: true
end
