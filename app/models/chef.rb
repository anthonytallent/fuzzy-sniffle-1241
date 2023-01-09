class Chef < ApplicationRecord
  validates_presence_of :name
  has_many :dishes
  has_many :dish_ingredients, through: :dishes
  has_many :ingredients, through: :dish_ingredients

  def chefs_unique_ingredients
    ingredients.all.distinct
  end

end