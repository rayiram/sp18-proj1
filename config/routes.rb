Rails.application.routes.draw do
  devise_for :trainers
  root to: "home#index"
  resources :trainers
  resources :pokemons
  patch "/capture/:id", to: "pokemons#capture", as: "capture"
  patch "/damage/:id", to: "pokemons#damage", as: "damage"
  post "new", to: "pokemons#new", as: "new"
  post "create", to: "pokemons#create", as: "create"
  patch "/heal/:id", to: "pokemons#heal", as: "heal"
end
