require 'rails_helper'

RSpec.describe "dish show page" do
  before :each do
    @chef = Chef.create!(name: "Cookie Monster")
    @dish = Dish.create!(name: "Mom's Spaghetti", description: "Made with love", calorie_count: 800, chef_id: @chef.id)

    @ingredient_1 = Ingredient.create!(name: "Spaghetti Noodles",)
    @ingredient_2 = Ingredient.create!(name: "Marinara Sauce")

    DishIngredient.create!(dish_id: @dish.id, ingredient_id: @ingredient_1.id)
    DishIngredient.create!(dish_id: @dish.id, ingredient_id: @ingredient_2.id)
  end
  
  it 'displays a dishes name and description' do
    visit dish_path(@dish)

    expect(page).to have_content(@dish.name)
    expect(page).to have_content(@dish.description)
  end

  it 'displays the list of ingredients for that dish' do
    visit dish_path(@dish)
    within("#ingredients") do
      expect(page).to have_content(@dish.ingredients.first.name)
      expect(page).to have_content(@dish.ingredients.second.name)
    end
  end

  it 'will display the chefs name' do
    visit dish_path(@dish)

    expect(page).to have_content(@dish.chef.name)
  end
end