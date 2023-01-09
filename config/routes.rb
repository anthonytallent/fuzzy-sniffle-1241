Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :dishes, only: [:show]

  resources :chefs, only: [:show, :edit, :update] do
    resources :ingredients, only: [:index]
  end

  # resources :chef_ingredients, only: [:index]

  patch "/chefs/:id", to: "chefs#update"
end
