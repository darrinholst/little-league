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
    resources :games
  end

  match 'calendar/home', :to => 'calendar#home'
  match 'calendar.ics', :to => 'calendar#ical'
end
