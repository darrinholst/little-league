Pll::Application.routes.draw do
  devise_for :users

  root :to => 'home#index'

  resources :teams

  namespace :admin do
    match '', :to => 'home#index'
    resources :divisions
    resources :teams
    resources :players
    resources :coaches
    resources :fields
  end
end
