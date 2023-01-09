require 'rails_helper'

RSpec.describe "chefs ingredients index page" do
  before :each do
    @chef_1 = Chef.create!(name: "Cookie Monster")
    @chef_2 = Chef.create!(name: "Stanley")

    @dish_1 = Dish.create!(name: "Mom's Spaghetti", description: "Made with love", calorie_count: 800, chef_id: @chef_1.id)
    @dish_2 = Dish.create!(name: "Dad's Raviolli", description: "It's Something", calorie_count: 1300, chef_id: @chef_2.id)
    @dish_3 = Dish.create!(name: "buns", description: "Tey are buns", calorie_count: 200, chef_id: @chef_1.id)

    @ingredient_1 = Ingredient.create!(name: "Spaghetti Noodles",)
    @ingredient_2 = Ingredient.create!(name: "Marinara Sauce")
    @ingredient_3 = Ingredient.create!(name: "Mystery Meat")
    @ingredient_4 = Ingredient.create!(name: "Some Sauce")
    @ingredient_5 = Ingredient.create!(name: "dough")

    DishIngredient.create!(dish_id: @dish_1.id, ingredient_id: @ingredient_1.id)
    DishIngredient.create!(dish_id: @dish_1.id, ingredient_id: @ingredient_2.id)
    DishIngredient.create!(dish_id: @dish_2.id, ingredient_id: @ingredient_3.id)
    DishIngredient.create!(dish_id: @dish_2.id, ingredient_id: @ingredient_4.id)
    DishIngredient.create!(dish_id: @dish_3.id, ingredient_id: @ingredient_5.id)
    DishIngredient.create!(dish_id: @dish_1.id, ingredient_id: @ingredient_5.id)
  end

  it 'displays a chefs ingredients without repeating any' do
    visit chef_ingredients_path(@chef_1)

    within("#chefs_ingredients") do
      expect(page).to have_content(@ingredient_1.name)
      expect(page).to have_content(@ingredient_2.name)
      expect(page).to have_content(@ingredient_5.name)
    end
  end
end