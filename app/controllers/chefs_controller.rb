class ChefsController < ApplicationController

  def show
    @chef = Chef.find(params[:id])
  end

  def edit
    @chef = Chef.find(params[:id])
  end

  def update
    @chef = Chef.find(params[:id])
    @dish = Dish.find(params[:dish_id])
    @dish.update(chef_id: @chef.id)
    redirect_to chef_path(@chef)
  end
end