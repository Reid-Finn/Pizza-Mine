class Pizza < ApplicationRecord
  belongs_to :user
  belongs_to :company
  has_many :reviews
  has_many :users, through: :reviews
  accepts_nested_attributes_for :company
end
