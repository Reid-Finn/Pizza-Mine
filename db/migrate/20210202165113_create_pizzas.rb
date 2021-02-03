class CreatePizzas < ActiveRecord::Migration[6.1]
  def change
    create_table :pizzas do |t|
      t.string :name
      t.string :description
      t.belongs_to :user, foreign_key: true
      t.belongs_to :company, foreign_key: true

      t.timestamps
    end
  end
end
