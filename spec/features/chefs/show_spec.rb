require 'rails_helper'

RSpec.describe "chef show page" do
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
  end

  it 'displays the name of the chef' do
    visit chef_path(@chef_1)

    expect(page).to have_content(@chef_1.name)
  end

  it 'displays all the dishes' do
    visit chef_path(@chef_1)

    within("#dishes") do
      expect(page).to have_content(@chef_1.dishes.first.name)
      expect(page).to have_content(@chef_1.dishes.second.name)
    end
  end

  it 'can update a dish to be that chefs dish' do
    visit chef_path(@chef_1)

    within("#dishes") do
      expect(page).to have_content(@chef_1.dishes.first.name)
      expect(page).to have_content(@chef_1.dishes.second.name)
      expect(page).to_not have_content(@dish_2.name)
    end

    within("#dish_form") do
      expect(page).to have_content('dish id')
      expect(page).to have_field(:dish_id)
    end

    within("#dish_form") do
      fill_in(:dish_id, with: "#{@dish_2.id}")
      click_button "Add Dish"
    end

    within("#dishes") do
      expect(page).to have_content(@chef_1.dishes.first.name)
      expect(page).to have_content(@chef_1.dishes.second.name)
      expect(page).to have_content(@dish_2.name)
    end
  end

  it 'has a link to take me to the chefs ingredients index page' do
    visit chef_path(@chef_1)

    within("#ingredients") do
      expect(page).to have_link("My Ingredients")
      click_link "My Ingredients"
      expect(current_path).to eq(chef_ingredients_path(@chef_1))
    end
  end
end