class Company < ApplicationRecord
    has_many :pizzas
    validates :name, presence: true, uniqueness: true
  
   
  
  end