class Pizza < ApplicationRecord
    belongs_to :company
    belongs_to :user 
    has_many :reviews
    has_many :users, through: :reviews #people who have reviewed it
    has_one_attached :image
  
    validates :name, presence: true
    validate :not_a_duplicate
  
    scope :order_by_rating, -> {left_joins(:reviews).group(:id).order('avg(stars) desc')}
  
    def self.alpha
      order(:name)
    end
  
  
    def company_attributes=(attributes)
      self.company = Company.find_or_create_by(attributes) if !attributes['name'].empty?
      self.company
    end
  
    def thumbnail
      self.image.variant(resize: "100x100")
    end
  
    def not_a_duplicate
      pizza = Pizza.find_by(name: name)
      if !!pizza && pizza != self
        errors.add(:name, 'has already been added for that brand')
      end
    end
  
    def company_name
      company.try(:name)
    end
  
    def name_and_company
      "#{name} - #{company.try(:name)}"
    end
  
  
  end